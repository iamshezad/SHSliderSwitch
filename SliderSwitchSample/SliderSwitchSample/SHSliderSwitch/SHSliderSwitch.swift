//
//  SHSliderSwitch.swift
//  SHSliderSwitch
//
//  Created on 04/02/19.
//  Copyright © 2019 iamShezad. All rights reserved.
//


import Foundation
import UIKit

@IBDesignable public class SHSliderSwitch: UIControl{
    
    /// Current value of the switch. Defaults to 0.
    @objc @IBInspectable public var value: Double = 0 {
        didSet {
            value = min(maximumValue, max(minimumValue, value))
            
            label.text = "\(formattedValue ?? "")"
            
            if oldValue != value {
                sendActions(for: .valueChanged)
            }
        }
    }
    
    private var formattedValue: String? {
        return formatter.string(from: NSNumber(value: value))
    }
    
    
    /// Minimum value. Must be less than maximumValue. Defaults to 0.
    @objc @IBInspectable public var minimumValue: Double = 0 {
        didSet {
            value = min(maximumValue, max(minimumValue, value))
        }
    }
    
    /// Maximum value. Must be more than minimumValue. Defaults to 100.
    @objc @IBInspectable public var maximumValue: Double = 100 {
        didSet {
            value = min(maximumValue, max(minimumValue, value))
        }
    }
    
    /// Increment value  in switch. Defaults to 1.
    @objc @IBInspectable public var stepValue: Double = 1 {
        didSet {
            setupNumberFormatter()
        }
    }
    
    
    /// Text color of the circular label. Defaults to white.
    @objc @IBInspectable public var labelTextColor: UIColor = UIColor.black {
        didSet {
            label.textColor = labelTextColor
        }
    }
    
    /// Background color of the circular label. Defaults to lighter blue.
    @objc @IBInspectable public var labelBackgroundColor: UIColor = UIColor.white {
        didSet {
            label.backgroundColor = labelBackgroundColor
        }
    }
    
    /// Font of the circular label. Defaults to Futura-Medium, 14.0 points in size.
    @objc public var labelFont = UIFont(name: "Futura-Medium", size: 14.0)! {
        didSet {
            label.font = labelFont
        }
    }
    
    /// Border width of the switch and circular label's layer. Defaults to 0.0.
    @objc @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            label.layer.borderWidth = borderWidth
        }
    }
    
    /// Color of the border of the switch and circular label's layer. Defaults to clear color.
    @objc @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            label.layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Font of the buttons. Defaults to Futura-Bold, 20.0 points in size.
    @objc public var buttonsFont = UIFont(name: "Futura-Bold", size: 20.0)! {
        didSet {
            for button in [leftButton, rightButton] {
                button.titleLabel?.font = buttonsFont
            }
        }
    }
    
    /// Text color of the buttons. Defaults to white.
    @objc @IBInspectable public var buttonsTextColor: UIColor = UIColor.white {
        didSet {
            for button in [leftButton, rightButton] {
                button.setTitleColor(buttonsTextColor, for: .normal)
            }
        }
    }
    
    let formatter = NumberFormatter()
    var labelOriginalCenter: CGPoint!
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(self.buttonsTextColor, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = self.buttonsFont
        button.addTarget(self, action: #selector(SHSliderSwitch.leftButtonAction), for: .touchDown)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(self.buttonsTextColor, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = self.buttonsFont
        button.addTarget(self, action: #selector(SHSliderSwitch.rightButtonAction), for: .touchDown)
        return button
    }()
    
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "\(formattedValue ?? "")"
        label.textColor = self.labelTextColor
        label.backgroundColor = self.labelBackgroundColor
        label.font = self.labelFont
        label.layer.cornerRadius = self.bounds.size.height/2
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.adjustsFontSizeToFitWidth = true
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SHSliderSwitch.handlePan))
        panRecognizer.maximumNumberOfTouches = 1
        label.addGestureRecognizer(panRecognizer)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        guard bounds.width >= (bounds.height+100) && bounds.height >= 30 else {
            return
        }
        self.setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard bounds.width >= (bounds.height+100) && bounds.height >= 30 else {
            return
        }
        setupUI()
    }
    
    private func setupUI(){
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(label)
        labelOriginalCenter = label.center
        
    }
    
    func setupNumberFormatter() {
        let decValue = Decimal(stepValue)
        let digits = decValue.significantFractionalDecimalDigits
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = digits
    }
    
    public override func layoutSubviews() {
        leftButton.frame = CGRect(x: 0, y: 0, width: 50, height: bounds.size.height)
        rightButton.frame = CGRect(x: bounds.width-50, y: 0, width: 50, height: bounds.size.height)
        label.frame = CGRect(x: (self.bounds.width/2-(self.bounds.height/2)), y: 0, width: self.bounds.size.height, height: bounds.size.height)
        labelOriginalCenter = label.center
    }
    
}

extension SHSliderSwitch{
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            leftButton.isEnabled = false
            rightButton.isEnabled = false
        case .changed:
            let translation = gesture.translation(in: label)
            gesture.setTranslation(CGPoint.zero, in: label)
            
            let slidingRight = gesture.velocity(in: label).x > 0
            let slidingLeft = gesture.velocity(in: label).x < 0
            
            let maxPoint = (self.bounds.width-(self.bounds.height/2))
            let minPoint = ((self.bounds.height/2))
            
            // Move the label with pan
            if slidingRight {
                label.center.x = min(maxPoint, label.center.x + translation.x)
            } else if slidingLeft {
                label.center.x = max(minPoint, label.center.x + translation.x)
            }
            
            if label.center.x == maxPoint{
                if value != maximumValue{
                    
                    value += stepValue
                }
            }else if label.center.x == minPoint{
                if value != minimumValue{
                    
                    value -= stepValue
                }
            }
            
        case .ended, .cancelled, .failed:
            UIView.animate(withDuration: 0.4, animations: {
                self.label.center = self.labelOriginalCenter
                self.layoutIfNeeded()
            }, completion: { (success) in
                self.leftButton.isEnabled = true
                self.rightButton.isEnabled = true
            })
            
        default:
            break
        }
    }
    
    @objc func leftButtonAction(button: UIButton) {
        if value != minimumValue{
            zoomIn(view: label)
            value -= stepValue
        }
        
    }
    
    @objc func rightButtonAction(button: UIButton) {
        if value != maximumValue{
            zoomIn(view: label)
            value += stepValue
        }
    }
    
    func zoomIn(view:UIView, duration: TimeInterval = 0.1) {
        view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
            view.transform = CGAffineTransform.identity
        })
    }
    
}

extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}
