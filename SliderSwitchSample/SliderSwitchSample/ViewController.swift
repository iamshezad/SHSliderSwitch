//
//  ViewController.swift
//  SliderSwitchSample
//
//  Created by Focaloid Technologies on 05/02/19.
//  Copyright © 2019 iamShezad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSliderSwitch()
    }

    func setupSliderSwitch(){
        let sliderFrame = CGRect(x: ((view.bounds.width/2)-75), y: view.bounds.height/2, width: 150, height: 40)
        let sliderSwitch = SHSliderSwitch(frame:sliderFrame)
        sliderSwitch.backgroundColor = UIColor.darkGray
        sliderSwitch.addTarget(self, action: #selector(ViewController.sliderValueChanged), for: .valueChanged)
        view.addSubview(sliderSwitch)
    }

    
    @objc func sliderValueChanged(sliderSwitch: SHSliderSwitch) {
        print("\(sliderSwitch.value) \n")
    }
}

