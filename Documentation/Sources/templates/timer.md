# Push template - Timer

## Properties

The properties below are used to define the payload sent to APNS:

| **Field** | **Required** | **Key** | **Type** | **Description** |
| :-------- | :----------- | :------ | :------- | :-------------- |
| Payload Version | ✅ | `adb_version` | string | Version of the payload assigned by the Adobe authoring UI. |
| Template Type | ✅ | `adb_template_type` | string | Informs the reader which properties may exist in the template object.<br /><br />Timer template uses a value of "timer". |
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
| Alternate title | ⛔️ | `adb_title_alt` | string | Alternate text for title of the notification after the timer has expired. |
| Alternate body | ⛔️ | `adb_body_alt` | string | Alternate text for body of the notification after the timer has expired. |
| Alternate expanded body | ⛔️ | `adb_body_ex_alt` | string | Alternate text for body of the notification when the message is expanded after the timer has expired. |
| Alternate image | ⛔️ | `adb_media_alt` | string | Alternate URI for an image shown when notification is expanded after the timer has expired. |
| Color - Timer | ⛔️ | `adb_clr_tmr` | string | Color for the text of the timer overlay.<br /><br />Represented as six character hex, e.g. `00FF00` |
| Timer duration | ⛔️ | `adb_tmr_dur` | string | If present, the timer on the notification will run for the number of seconds provided here. |
| Timer end timestamp | ⛔️ | `adb_tmr_end` | string | If present, the timer on the notification will count down until this epoch time (in seconds). <br /><br />**Note** - if both `adb_tmr_end` and `adb_tmr_dur` are present, `adb_tmr_dur` will be used and `adb_tmr_end` will be ignored. |

For more information on APNS payload keys, see [Apple's documentation](https://developer.apple.com/documentation/usernotifications/generating-a-remote-notification).

## Example

Below is a sample of what a payload might look like for a notification using the timer template:

```json
{
    "aps": {
        "alert": {
            "title": "Limited time offer!",
            "body": "Don't miss out on your chance for deep discounts",
            "subtitle": "Click for more information"
        },
        "sound": "sneakerSqueek",
        "badge": 1,
        "mutable-content": 1,
        "category": "AEPNotification",
        "thread-id": "apparel",
        "content-available": 1
    },
    "adb_media": "https://bigboxretailer.com/sale.png",
    "adb_uri": "https://bigboxretailer.com/sale",
    "adb_version": "1",
    "adb_template_type": "timer",
    "adb_body_ex": "These discounts won't be around for long, click on the notification to go check out the sale.",
    "adb_title_alt": "You missed out on the sale.",
    "adb_body_alt": "Our next flash sale will be sometime next month.",
    "adb_body_ex_alt": "Sorry you missed us this time. Check back next month for some deep discounts.",
    "adb_media_alt": "https://bigboxretailer.com/sale_ended.png",
    "adb_clr_body": "333333",
    "adb_clr_title": "000000",
    "adb_clr_bg": "FFFFFF",
    "adb_clr_tmr": "000000",
    "adb_tmr_end": "1703462400",
    "some_custom_data_key": "some data"
}
```