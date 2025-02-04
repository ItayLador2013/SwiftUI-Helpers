# ScrollView Independent Grid 

Scrollable grid for a list where item's positioning can be changed throughout the session without affecting the positioning of the other items on the grid.

```swift
init(
  list : [ListItemType],
  item_size: CGSize,
  container_width : CGFloat = UIScreen.main.bounds.width,
  expanded : ListItemType? = nil,
  @ViewBuilder _ label: @escaping (ListItemType) -> Label
)
```

## Example Usage
```swift
IndependentScrollViewGrid(list: images, item_size: CGSize(width: IMAGE_WIDTH, height: IMAGE_HEIGHT)) { image in
  \\Grid item in here
}
```
