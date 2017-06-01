//
//  ViewController.swift
//  Meow
//
//  Created by Jessica Yeh on 4/25/17.
//  Copyright © 2017 Jessica Yeh. All rights reserved.
//

import MobileCenterAnalytics
import UIKit
import FlatUIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cat: UIImageView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var envLabel: UILabel!
    
    @IBOutlet weak var sendCrashButton: FUIButton!
    @IBOutlet weak var sendEventButton: FUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stylizeButton(button: self.sendCrashButton, color: UIColor.alizarin(), shadowColor: UIColor.pomegranate())
        self.stylizeButton(button: self.sendEventButton, color: UIColor.peterRiver(), shadowColor: UIColor.belizeHole())
        
        self.setVersionAndBuildLabels()
        self.setEnvLabel()
        
        // Animating background color seems to interfere with button presses 😭
//        self.animateToRandomBackgroundColor()
//        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.animateToRandomBackgroundColor), userInfo: nil, repeats: true)
        
        self.animateCat()
//        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.animateCat), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func crash(_ sender: Any) {
        let fruits = ["Apple", "Banana", "Orange"]
        let pear = fruits[3]
        print(pear)
    }
    
    @IBAction func sendEvent(_ sender: Any) {
        MSAnalytics.trackEvent("Meow!")
        self.animateCat()
    }
    
    func stylizeButton(button: FUIButton, color: UIColor, shadowColor: UIColor) {
        button.buttonColor = color
        button.shadowColor = shadowColor
        button.shadowHeight = 3.0
        button.cornerRadius = 6.0
        button.titleLabel?.font = UIFont.boldFlatFont(ofSize: 16.0)
        button.setTitleColor(UIColor.clouds(), for: .normal)
        button.setTitleColor(UIColor.clouds(), for: .highlighted)
    }
    
    func setVersionAndBuildLabels() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        self.versionLabel.text = "Version: \(version)"
        let build = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as! String
        self.buildLabel.text = "Build: \(build)"
    }
    
    func setEnvLabel() {
        #if INT
            self.envLabel.text = "INT"
        #endif
        #if STAGING
            self.envLabel.text = "STAGING"
        #endif
        #if PROD
            self.envLabel.text = "PROD"
        #endif
    }
    
    func animateToRandomBackgroundColor() {
        UIView.animate(withDuration: 2, animations: {
            self.view.backgroundColor = self.randomColor()
        }, completion: nil)
    }
    
    func animateCat() {
        UIView.animate(withDuration: 0.25, animations: {
            self.cat.frame.origin.y -= 20
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, animations: {
                self.cat.frame.origin.y += 20
            }, completion: nil)
        })
    }

    private func randomColor() -> UIColor {
        return UIColor(red: randomNumber(),
                       green: randomNumber(),
                       blue: randomNumber(),
                       alpha: 1.0)
    }
    
    // Random float between 0 and 1
    private func randomNumber() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
}

