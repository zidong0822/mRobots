# BetterSegmentedControl

[![Version](https://img.shields.io/cocoapods/v/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)
[![Platform](https://img.shields.io/cocoapods/p/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)

BetterSegmentedControl is an easy to use, customizable replacement for UISegmentedControl and UISwitch written in Swift.

![Demo](https://media.giphy.com/media/3oGRFxAEaoAAjqnZ6g/giphy.gif)

## Features

- [x] Can be used as a segmented control or switch
- [x] Plethora of customizable options from colors to insets and radii
- [x] Designable straight in Interface Builder
- [x] Customizable behavior
- [x] Error handling

## Requirements

- iOS 8.0+
- Xcode 7.3+

## Installation

### CocoaPods

BetterSegmentedControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BetterSegmentedControl', '~> 0.3'
```

### Carthage

If you prefer using [Carthage](https://github.com/Carthage/Carthage), simply add BetterSegmentedControl to your `Cartfile`:

```ruby
github "gmarm/BetterSegmentedControl" ~> 0.3
```

### Manually

If you prefer not to use CocoaPods or Carthage, you can integrate BetterSegmentedControl into your project manually.

## Usage

```swift
let control = BetterSegmentedControl(
    frame: CGRect(x: 0.0, y: 100.0, width: view.bounds.width, height: 44.0),
    titles: ["One", "Two", "Three"],
    index: 1,
    backgroundColor: UIColor(red:0.11, green:0.12, blue:0.13, alpha:1.00),
    titleColor: .whiteColor(),
    indicatorViewBackgroundColor: UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00),
    selectedTitleColor: .blackColor())
control.titleFont = UIFont(name: "HelveticaNeue", size: 14.0)!
control.addTarget(self, action: #selector(ViewController.controlValueChanged(_:)), forControlEvents: .ValueChanged)
view.addSubview(control)
```
You can find different ways of using it (such as by designing it in a Storyboard file) in the example project. To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Todos

- [ ] Make initializer failable if not enough titles are passed.
- [ ] Set titles via method that throws.
- [ ] Allow UIViews that implement a protocol to be used as options.
- [ ] Add moar tests!
- [ ] ~~Try to take over the world!~~ Uh, what?

## Contribution

Feel free to fork, submit Pull Requests or send me your feedback and suggestions!

## Author

George Marmaridis

- https://github.com/gmarm
- https://twitter.com/gmarmas
- https://www.linkedin.com/in/gmarm
- gmarmas@gmail.com

## License

BetterSegmentedControl is available under the MIT license. See the LICENSE file for more info.

I'd greatly appreciate it if you [drop me a line](https://twitter.com/gmarmas) if you decide using it in one of your apps.
