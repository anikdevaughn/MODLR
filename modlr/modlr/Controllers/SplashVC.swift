//
//  SplashVC.swift
//  modlr-test
//
//  Created by Chris Slowik on 2/16/16.
//  Copyright © 2016 Creativedash. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var brandingRect: UIView!
    @IBOutlet weak var titleText: UIImageView!
    
    let bgOriginScale = CGAffineTransformMakeScale(1.1, 1.1)
    let bgOriginTranslation = CGAffineTransformMakeTranslation(0, 20)
    let brandingOriginScale = CGAffineTransformMakeScale(0.9, 0.9)
    let brandingOriginTranslation = CGAffineTransformMakeTranslation(0, 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.transform = CGAffineTransformConcat(bgOriginScale, bgOriginTranslation)
        brandingRect.transform = CGAffineTransformConcat(brandingOriginScale, brandingOriginTranslation)
        
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.backgroundView.transform = CGAffineTransformIdentity
            self.brandingRect.transform = CGAffineTransformIdentity
            }, completion: nil)
        
        brandingRect.layer.shadowColor = UIColor(red:0.129,  green:0.110,  blue:0.043, alpha:1).CGColor
        brandingRect.layer.shadowOffset = CGSize(width: 0, height: 40)
        brandingRect.layer.shadowRadius = 60.0
        brandingRect.layer.shadowOpacity = 0.8
        
        let shadowRadiusAnimation = CABasicAnimation(keyPath: "shadowRadius")
        shadowRadiusAnimation.fromValue = 10
        shadowRadiusAnimation.toValue = 60
        let shadowOpacityAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowOpacityAnimation.fromValue = 0
        shadowOpacityAnimation.toValue = 0.8
        let shadowAnimation = CAAnimationGroup()
        shadowAnimation.duration = 1
        shadowAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        shadowAnimation.animations = [shadowRadiusAnimation, shadowOpacityAnimation]
        brandingRect.layer.addAnimation(shadowAnimation, forKey: "shadow")
    }

}
