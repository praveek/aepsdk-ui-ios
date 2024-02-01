/*
 Copyright 2024 Adobe. All rights reserved.
 This file is licensed to you under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License. You may obtain a copy
 of the License at http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software distributed under
 the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
 OF ANY KIND, either express or implied. See the License for the specific language
 governing permissions and limitations under the License.
 */

import UIKit

/// Utility class to download images asynchronously
class ImageDownloader {
    /// Downloads images from the provided URLs.
    /// - Parameters:
    ///   - urls: Array of string URLs for the images to be downloaded.
    ///   - completion: Completion block with a dictionary of URL to UIImage pairs and an optional error.
    func downloadImages(urls: [String], completion: @escaping ([String: UIImage]?, ImageDownloadError?) -> Void) {
        var validURLs: [URL] = []
        let result = validateURLs(urls: urls)
        switch result {
        case let .success(urls):
            validURLs = urls
        case let .failure(error):
            completion(nil, error)
        }

        let downloadGroup = DispatchGroup()
        var downloadedImages: [String: UIImage] = [:]
        var errors = [ImageDownloadError]()

        // Download images concurrently
        for url in validURLs {
            downloadGroup.enter()
            downloadImage(url: url) { result in
                switch result {
                case let .success(image):
                    downloadedImages[url.absoluteString] = image
                case let .failure(error):
                    errors.append(error)
                }
                downloadGroup.leave()
            }
        }

        // Notify the main queue when all downloads are complete
        downloadGroup.notify(queue: .main) {
            if errors.isEmpty {
                completion(downloadedImages, nil)
            } else {
                completion(nil, .multipleErrors(errors: errors))
            }
        }
    }

    /// Downloads a single image from the given URL.
    ///
    /// - Parameters:
    ///   - url: `URL` of the image to download.
    ///   - completion: A `Result` value  called with the downloaded image or an ImageDownloadError.
    private func downloadImage(url: URL, completion: @escaping (Result<UIImage, ImageDownloadError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            // if there is an error downloading image send
            if let error = error {
                completion(.failure(.networkError(url: url.absoluteString, error: error)))
                return
            }

            // convert the data into image
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(.invalidImageData(url: url.absoluteString)))
                return
            }

            // on successful download call the completion with success
            completion(.success(image))
        }.resume()
    }

    /// Validates a list of URL strings.
    ///
    /// This method takes an array of strings, each expected to represent a URL, and attempts to convert them into `URL` objects.
    /// It checks each string and validates whether it can be transformed into a valid URL
    ///
    /// - Parameter urls: An array of strings, where each string is intended to be a URL.
    /// - Returns: A `Result` type. On success, it contains an array of `URL` objects corresponding to the valid URL strings. On failure, it contains an `ImageDownloaderError`.
    private func validateURLs(urls: [String]) -> Result<[URL], ImageDownloadError> {
        var validatedUrls: [URL] = []
        var errors: [ImageDownloadError] = []

        // Validate URLs
        for urlString in urls {
            guard let url = URL(string: urlString) else {
                errors.append(.invalidURL(url: urlString))
                continue
            }
            validatedUrls.append(url)
        }

        if !errors.isEmpty {
            return .failure(.multipleErrors(errors: errors))
        }

        return .success(validatedUrls)
    }
}

/// Enum representing possible errors that can occur during image downloading.
enum ImageDownloadError: Error {
    /// Error indicating that a provided URL string to download image is invalid.
    case invalidURL(url: String)

    /// Error indicating a network-related issue occurred while downloading an image.
    case networkError(url: String, error: Error)

    /// Error indicating that the downloaded data could not be converted into an image.
    case invalidImageData(url: String)

    /// Error representing multiple image downloading errors.
    /// In batch download scenarios this error aggregates all individual errors into a single error case.
    case multipleErrors(errors: [ImageDownloadError])

    var description: String {
        switch self {
        case let .invalidURL(url):
            return "Invalid URL: \(url)"
        case let .networkError(url, error):
            return "Network error at \(url): \(error.localizedDescription)"
        case let .invalidImageData(url):
            return "Failed to convert downloaded data to image at \(url)"
        case let .multipleErrors(errors):
            let errorDescriptions = errors.map { $0.description }
            return "Image Downloader error: \n" + errorDescriptions.joined(separator: " \n")
        }
    }
}
