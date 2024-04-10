# Push template - Carousel

A notification that shows a series of two (2) to five (5) images that scroll on/off the sides of the notification.

If operating in `automatic` mode, images will rotate every five (5) seconds.  If operating in manual mode, the user is required to push a button to advance forwards or backwards through the carousel.

## Push notification properties

For full information on APNS payload keys, see [Apple's documentation](https://developer.apple.com/documentation/usernotifications/generating-a-remote-notification).

The properties below are used to define the payload sent to APNS:

### APS properties

| **Field** | **Required** | **Key** | **Type** | **Description** |
| :-------- | :----------- | :------ | :------- | :-------------- |
| Title | ✅ | `aps.alert.title` | string | Text shown in the notification's title. |
| Subtitle | ⛔️ | `aps.alert.subtitle` | string | Text shown in subtitle of notification. |
| Body | ✅ | `aps.alert.body` | string | Text shown in message body when notification is collapsed. |
| Notification Category | ✅ | `aps.category` | string | The notification’s type. This string must correspond to the identifier of one of the `UNNotificationCategory` objects you register at launch time.<br /><br />Value will always be "AEPNotification" to use an Adobe push template. |
| Mutable content | ✅ | `aps.mutable-content` | number | The notification service app extension flag. If the value is 1, the system passes the notification to your notification service app extension before delivery. Use your extension to modify the notification’s content.<br /><br />Value must always equal 1 so that the app's notification content service is called prior to the notification being displayed to the user. |
| Sound | ⛔️ | `aps.sound` | string | The name of a sound file in your app’s main bundle or in the Library/Sounds folder of your app’s container directory. Specify the string “default” to play the system sound. Use this key for regular notifications. For critical alerts, use the sound dictionary instead. |
| Badge Count | ⛔️ | `aps.badge` | string | The number to display in a badge on your app’s icon. Specify 0 to remove the current badge, if any. |
| Notification Thread ID | ⛔️ | `aps.thread-id` | string | An app-specific identifier for grouping related notifications. This value corresponds to the `threadIdentifier` property in the `UNNotificationContent` object. |

### AEPNotificationContent properties

| **Field** | **Required** | **Key** | **Type** | **Description** |
| :-------- | :----------- | :------ | :------- | :-------------- |
| Payload Version | ✅ | `adb_version` | string | Version of the payload assigned by the Adobe authoring UI. |
| Template Type | ✅ | `adb_template_type` | string | Informs the reader which properties may exist in the template object.<br /><br />Carousel template uses a value of "car". |
| Expanded Title | ⛔️ | `adb_title_ex` | string | Title of the message when the notification is expanded.<br /><br />If an expanded title is not provided, the value in `aps.alert.title` will be used. |
| Link URI | ⛔️ | `adb_uri` | string | URI to be handled when the user clicks on the unexpanded notification or on a carousel item that has not provided its own `uri`.<br /><br />If no value is provided, clicking on the notification will open the host application. |
| Operation mode | ⛔️ | `adb_car_mode` | string | Determines how the carousel will be operated.<br /><br />Valid values are "auto" or "manual".<br /><br />Default value is "auto". |
| Carousel layout type | ⛔️ | `adb_car_layout` | string | Determines how the carousel items will be displayed.<br /><br />Valid values are "default" (full screen images) or "filmstrip" (bordered images to make them look like part of a roll of film).<br /><br />Default value is "default". |
| Carousel items | ✅ | `adb_items` | array | Two to five items in the carousel defined by the following object:<ul><li>`img` (*required*) - URI to an image to be shown for the carousel item</li><li>`txt` (*optional*) - caption to show when the carousel item is visible</li><li>`uri` (*optional*) - URI to handle when the item is touched by the user.<br />If no `uri` is provided for the item, `adb_uri` will be handled instead.</li></ul> |
| Color - Title | ⛔️ | `adb_clr_title` | string | Text color for `adb_title_ex`. Represented as six character hex, e.g. `00FF00`<br /><br />If no value is provided, the system [label color](https://developer.apple.com/documentation/uikit/uicolor/3173131-label) will be used. |
| Color - Body | ⛔️ | `adb_clr_body` | string | Text color for `adb_body_ex`. Represented as six character hex, e.g. `00FF00`<br /><br />If no value is provided, the system [secondaryLabel color](https://developer.apple.com/documentation/uikit/uicolor/3173136-secondarylabel) will be used. |
| Color - Background | ⛔️ | `adb_clr_bg` | string | Color for notification's background. Represented as six character hex, e.g. `00FF00`<br /><br />If no value is provided, the system [systemBackground color](https://developer.apple.com/documentation/uikit/uicolor/3173140-systembackground) will be used. |


## Example

Below is a sample of what a payload might look like for a notification using a carousel template:

```json
{
    "aps": {
        "alert": {
            "title": "New shoes in stock!",
            "subtitle": "Shoes that will knock your socks off!",
            "body": "Come check out the sweet new kicks we just got in stock."
        },
        "category": "AEPNotification",
        "mutable-content": 1,
        "sound": "sneakerSqueek",
        "badge": 1,
        "thread-id": "apparel"
    },
    "adb_version": "1",
    "adb_template_type": "car",
    "adb_title_ex": "The spring sale is in full swing!",
    "adb_uri": "https://sneakerland.com/products/new",
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
    "adb_clr_body": "333333",
    "adb_clr_title": "000000",
    "adb_clr_bg": "FFFFFF",
    "some_custom_data_key": "some data"
}
```