# Holding Button 

A button view requiring easy implentation of "on hold" and "on press" actions.

```swift
HoldingButton<Label> : View where Label : View

init(on_hold: @escaping () -> Void, on_press: @escaping () -> Void, label : @escaping (Bool) -> Label)
```

## Example Usage
```swift
HoldingButton(
    on_hold: {
        //action to perform on hold
    },
    on_press: {
        //action to perform when pressed
    }
 ) { holding in 
    //Your inner button View
 }
```
