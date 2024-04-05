# Push template - Basic

### Properties

The properties below are used to define the payload sent to APNS:

| **Field** | **Required** | **Key** | **Type** | **Description** |
| :-------- | :----------- | :------ | :------- | :-------------- |
| Payload Version | ✅ | `adb_version` | string | Version of the payload assigned by the Adobe authoring UI. |
| Template Type | ✅ | `adb_template_type` | string | Informs the reader which properties may exist in the template object.<br /><br />Basic template uses a value of "basic". |
| Title | ✅ | `aps.alert.title` | string | Text shown in the notification's title. |
| Color - Title | ⛔️ | `adb_clr_title` | string | Text color for `aps.alert.title`.<br /><br />Represented as six character hex, e.g. `00FF00` |
| Subtitle | ⛔️ | `aps.alert.subtitle` | string | Text shown in subtitle of notification. |
| Body | ✅ | `aps.alert.body` | string | Text shown in message body when notification is collapsed. |
| Expanded Body | ⛔️ | `adb_body_ex` | string | Body of the message when the message is expanded. |
| Color - Body | ⛔️ | `adb_clr_body` | string | Text color for `aps.alert.body`, `adb_body_ex`.<br /><br />Represented as six character hex, e.g. `00FF00` |
| Sound | ⛔️ | `aps.sound` | string | The name of a sound file in your app’s main bundle or in the Library/Sounds folder of your app’s container directory. Specify the string “default” to play the system sound. Use this key for regular notifications. For critical alerts, use the sound dictionary instead. |
| Badge Count | ⛔️ | `aps.badge` | string | The number to display in a badge on your app’s icon. Specify 0 to remove the current badge, if any. |
| Notification Type | ✅ | `aps.category` | string | The notification’s type. This string must correspond to the identifier of one of the `UNNotificationCategory` objects you register at launch time.<br /><br />Value will always be "AEPNotification" to use an Adobe push template. |
| Notification Grouping ID | ⛔️ | `aps.thread-id` | string | An app-specific identifier for grouping related notifications. This value corresponds to the `threadIdentifier` property in the `UNNotificationContent` object. |
| Content available | ⛔️ | `aps.content-available` | number | The background notification flag. To perform a silent background update, specify the value 1 and don’t include the alert, badge, or sound keys in your payload. |
| Mutable content | ✅ | `aps.mutable-content` | number | The notification service app extension flag. If the value is 1, the system passes the notification to your notification service app extension before delivery. Use your extension to modify the notification’s content.<br /><br />Value must always equal 1 so that the app's notification content service is called prior to the notification being displayed to the user. |
| Image | ⛔️ | `adb_media` | string | URI of an image to be shown when notification is expanded. |
| Link URI | ⛔️ | `adb_uri` | string | URI to be handled when user clicks the notification body. <br /><br />For example, a deep link to your app or a URI to a webpage. |
| Color - Background | ⛔️ | `adb_clr_bg` | string | Color for notification's background.<br /><br />Represented as six character hex, e.g. `00FF00` |

For more information on APNS payload keys, see [Apple's documentation](https://developer.apple.com/documentation/usernotifications/generating-a-remote-notification).

### Example

Below is a sample of what a payload might look like for a basic notification:

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
    "adb_media": "www.imageUrl.com",
    "adb_uri": "deeplinkUrl/weburl",
    "adb_version": "1",
    "adb_template_type": "basic",
    "adb_body_ex": "There are some great new deals in here that we really think you're going to like! Check it out!",
    "adb_clr_body": "333333",
    "adb_clr_title": "000000",
    "adb_clr_bg": "FFFFFF",
    "some_custom_data_key": "some data"
}
```