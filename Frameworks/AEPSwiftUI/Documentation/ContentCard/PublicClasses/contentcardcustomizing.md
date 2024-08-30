# ContentCardCustomizing

Protocol that defines method for customizing content card based on the template type.


## Protocol Definition
```swift
protocol ContentCardCustomizing {
    func customize(template: SmallImageTemplate)
}
```

## Methods

### customize 

Implement this function to customize content cards with [SmallImageTemplate](../PublicClasses/Template/smallimage-template.md).

#### Parameters

- _template_ - The `SmallImageTemplate` instance to be customized.

``` swift
func customize(template: SmallImageTemplate)
```