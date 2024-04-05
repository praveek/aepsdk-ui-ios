# Push template - Carousel

## Properties

The properties below are used to define the payload sent to APNS:

| **Field** | **Required** | **Key** | **Type** | **Description** |
| :-------- | :----------- | :------ | :------- | :-------------- |
| Payload Version | ✅ | `adb_version` | string | Version of the payload assigned by the Adobe authoring UI. |
| Template Type | ✅ | `adb_template_type` | string | Informs the reader which properties may exist in the template object.<br /><br />Carousel template uses a value of "car". |
| Title | ✅ | `aps.alert.title` | string | Text shown in the notification's title. |
| Color - Title | ⛔️ | `adb_clr_title` | string | Text color for `aps.alert.title`.<br /><br />Represented as six character hex, e.g. `00FF00` |
| Subtitle | ⛔️ | `aps.alert.subtitle` | string | Text shown in subtitle of notification. |
| Body | ✅ | `aps.alert.body` | string | Text shown in message body when notification is collapsed. |
| Expanded Body | ⛔️ | `adb_body_ex` | string | Body of the message when the message is expanded. |
| Color - Body | ⛔️ | `adb_clr_body` | string | Text color for `aps.alert.body`, `adb_body_ex`.<br /><br />Represented as six character hex, e.g. `00FF00` |
| Notification Category | ✅ | `aps.category` | string | The notification’s type. This string must correspond to the identifier of one of the `UNNotificationCategory` objects you register at launch time.<br /><br />Value will always be "AEPNotification" to use an Adobe push template. |
| Mutable content | ✅ | `aps.mutable-content` | number | The notification service app extension flag. If the value is 1, the system passes the notification to your notification service app extension before delivery. Use your extension to modify the notification’s content.<br /><br />Value must always equal 1 so that the app's notification content service is called prior to the notification being displayed to the user. |
| Sound | ⛔️ | `aps.sound` | string | The name of a sound file in your app’s main bundle or in the Library/Sounds folder of your app’s container directory. Specify the string “default” to play the system sound. Use this key for regular notifications. For critical alerts, use the sound dictionary instead. |
| Badge Count | ⛔️ | `aps.badge` | string | The number to display in a badge on your app’s icon. Specify 0 to remove the current badge, if any. |
| Notification Thread ID | ⛔️ | `aps.thread-id` | string | An app-specific identifier for grouping related notifications. This value corresponds to the `threadIdentifier` property in the `UNNotificationContent` object. |
| Content available | ⛔️ | `aps.content-available` | number | The background notification flag. To perform a silent background update, specify the value 1 and don’t include the alert, badge, or sound keys in your payload. |
| Image | ⛔️ | `adb_media` | string | URI of an image to be shown when notification is expanded. |
| Link URI | ⛔️ | `adb_uri` | string | URI to be handled when user clicks the notification body. <br /><br />For example, a deep link to your app or a URI to a webpage. |
| Color - Background | ⛔️ | `adb_clr_bg` | string | Color for notification's background.<br /><br />Represented as six character hex, e.g. `00FF00` |
| Operation mode | ⛔️ | `adb_car_mode` | string | Determines how the carousel will be operated.<br /><br />Valid values are "auto" or "manual".<br /><br />Default value is "auto". |
| Carousel layout type | ⛔️ | `adb_car_layout` | string | Determines how the carousel items will be displayed.<br /><br />Valid values are "default" (full screen images) or "filmstrip" (bordered images to make them look like part of a roll of film).<br /><br />Default value is "default". |
| Carousel items | ✅ | `adb_items` | array | Two to five items in the carousel defined by the following object:<ul><li>`img` (required) - URI to an image to be shown for the carousel item</li><li>`txt` (optional) - caption to show when the carousel item is visible</li><li>`uri` (optional) - URI to handle when the item is touched by the user.<br />If no uri  is provided for the item, adb_uri will be handled instead.</li></ul> |

For more information on APNS payload keys, see [Apple's documentation](https://developer.apple.com/documentation/usernotifications/generating-a-remote-notification).

## Example

Below is a sample of what a payload might look like for a notification using a carousel template:

```json
{
    "aps": {
        "alert": {
            "title": "New shoes in stock!",
            "body": "Come check out the sweet new kicks we just got in stock.",
            "subtitle": "Shoes that will knock your socks off!"
           },
        "sound": "sneakerSqueek",
        "badge": 1,
        "mutable-content": 1,
        "category": "AEPNotification",
        "thread-id": "apparel",
        "content-available": 1
    },
    "adb_uri": "deeplinkUrl/weburl",
    "adb_version": "1",
    "adb_template_type": "car",
    "adb_clr_body": "333333",
    "adb_clr_title": "000000",
    "adb_clr_bg": "FFFFFF",
    "adb_car_mode": "auto",
    "adb_car_layout": "default",
    "adb_items": [
        {
            "img": "https://sneakerland.com/products/shoe1/shoe1.png",
            "txt": "Shoe 1 by Cool Sneaker Brand",
            "uri": "https://sneakerland.com/products/shoe1"
        },
        {
            "img": "https://sneakerland.com/products/shoe2/shoe2.png",
            "txt": "Shoe 2 by Lame Sneaker Brand",
            "uri": "https://sneakerland.com/products/shoe2"
        }
    ],  
    "some_custom_data_key": "some data"
}
```