# SHSliderSwitch
SHSliderSwitch is a simple lightweight library to implement an animated slider switch.

[![Swift 4.0](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-ios-blue.svg?style=flat)]()

<img src="/Screenshots/SHSliderSwitch.png" /> 

## Installation
Just drag and drop the SHSliderSWitch.swift file from SHSliderSWitch folder to your project.
#### Cocoapods
```swift
pod 'SHSliderSwitch'

```

## Usage

1. Just drag and drop an view in storyboard and set view class to SHSliderSWitch.

<img src="/Screenshots/SS1.png" /> 
 
2. How to configure: 

-- can configure using IBInspectable.

<img src="/Screenshots/SS2.png" /> 

-- configure manually.
```swift
  //Current value of the switch. Defaults to 0.
  sliderSwitch.value = 0.0
  
  /// Minimum value. Must be less than maximumValue. Defaults to 0.
  sliderSwitch.minimumValue = 0.0
  
  /// Maximum value. Must be more than minimumValue. Defaults to 100.
  sliderSwitch.maximumValue = 100.0
  
  /// Increment value  in switch. Defaults to 1.
  sliderSwitch.stepValue = 1
  
  /// Text color of the circular label. Defaults to white.
  sliderSwitch.labelTextColor = UIColor.white
  
  /// Background color of the circular label. Defaults to lighter white.
  sliderSwitch.labelBackgroundColor = UIColor.blue
  
  /// Font of the circular label. Defaults to Futura-Medium, 14.0 points in size.
  sliderSwitch.labelFont = UIFont(name: "Futura-Medium", size: 14.0)
  
  /// Border width of the switch and circular label's layer. Defaults to 0.0.
  sliderSwitch.borderColor = 0.0
  
  /// Color of the border of the switch and circular label's layer. Defaults to clear color.
  sliderSwitch.borderColor = UIColor.clear
  
  /// Font of the buttons. Defaults to Futura-Bold, 20.0 points in size.
  sliderSwitch.buttonsFont = UIFont(name: "Futura-Bold", size: 20.0)
  
  /// Text color of the buttons. Defaults to white.
  sliderSwitch.buttonsTextColor = UIColor.white
        

```

## Requirements

* iOS 11.0+

## Example

Download the Sample project.

## Contact

Mail me @: shezadahamed95@gmail.com

## Acknowledge

Inspired by  [GMStepper](https://github.com/gmertk/GMStepper)

## License

SHSliderSwitch is available under the MIT license. See the LICENSE file for more info.
