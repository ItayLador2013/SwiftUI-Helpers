# Holding Button 

A button view requiring easy implentation of "on hold" and "on press" actions.

```swift
init(on_hold: @escaping () -> Void, on_press: @escaping () -> Void,  diameter: CGFloat = BUTTON_DIAMETER)
```

## Example Usage
```swift
HoldingButton(
    on_hold: {
        \\action to perform on hold
    },
    on_press: {
        \\action to perform when pressed
    }
 )
```
