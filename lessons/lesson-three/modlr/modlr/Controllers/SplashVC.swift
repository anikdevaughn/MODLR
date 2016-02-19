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
    
    // initial transform values - we want to end on the identity transform,
    // because that will make things easier later
    let bgOriginScale = CGAffineTransformMakeScale(1.1, 1.1)
    let bgOriginTranslation = CGAffineTransformMakeTranslation(0, 20)
    let brandingOriginScale = CGAffineTransformMakeScale(0.90, 0.90)
    let brandingOriginTranslation = CGAffineTransformMakeTranslation(0, 10)
    
    var dots = [CAShapeLayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial transforms on objects
        view.backgroundColor = UIColor(red:0.325,  green:0.325,  blue:0.325, alpha:1)
        backgroundView.transform = CGAffineTransformConcat(bgOriginScale, bgOriginTranslation)
        brandingRect.transform = CGAffineTransformConcat(brandingOriginScale, brandingOriginTranslation)
        
        // create initial appearance for branding rect
        brandingRect.applyYellowGradient()
        brandingRect.layer.shadowColor = UIColor(red:0.133,  green:0.114,  blue:0.047, alpha:1).CGColor
        brandingRect.layer.shadowOffset = CGSize(width: 0, height: 40)
        brandingRect.layer.shadowRadius = 60
        brandingRect.layer.shadowOpacity = 0.8
        
        // animate background and branding rect parallax
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.backgroundView.transform = CGAffineTransformIdentity
            self.brandingRect.transform = CGAffineTransformIdentity
            }) { (success) -> Void in
                //completion
        }
        
        // animate shadow to simulate "lift"
        let shadowRadiusAnimation = CABasicAnimation(keyPath: "shadowRadius")
        shadowRadiusAnimation.fromValue = 10
        shadowRadiusAnimation.toValue = 60
        let shadowOpacityAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowOpacityAnimation.fromValue = 0
        shadowOpacityAnimation.toValue = 0.8
        let shadowAnimation = CAAnimationGroup()
        shadowAnimation.animations = [shadowRadiusAnimation, shadowOpacityAnimation]
        shadowAnimation.duration = 1
        shadowAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        brandingRect.layer.addAnimation(shadowAnimation, forKey: "shadow")
        
        placeDots()
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: - Drawing
    func placeDots() {
        let dotInfo: [[CGFloat]] = [
            [1.5, 79, 17],
            [1.5, 79, 143],
            [3, 187.5, 80],
            [1.5, 296, 17],
            [1.5, 187.5, 205],
            [1.5, 296, 143],
            [1.5, 79, 518.5],
            [3, 187.5, 455.5],
            [1.5, 296, 392],
            [3, 79, 643.5],
            [1.5, 187.5, 581],
            [1.5, 296, 518.5],
            [3, 296, 643.5]]
        
        for dot in dotInfo {
            dots.append(drawDotWithRadius(dot[0], coords: CGPoint(x: dot[1], y: dot[2])))
        }
        
        for (index, dot) in dots.enumerate() {
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = 0.0
            scaleAnimation.toValue = 1.0
            scaleAnimation.duration = 1
            scaleAnimation.beginTime = CACurrentMediaTime() + 0.1 * Double(index)
            scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            scaleAnimation.fillMode = kCAFillModeBoth
            
            dot.addAnimation(scaleAnimation, forKey: "transform.scale")
            backgroundView.layer.addSublayer(dot)
        }
    }
    
    func drawDotWithRadius(radius: CGFloat, coords: CGPoint) -> CAShapeLayer {
        // adjust coordinates based on screen
        let XScale = UIScreen.mainScreen().bounds.width / 375
        let YScale = UIScreen.mainScreen().bounds.height / 667
        // make draw rect based on coords and radius
        let circleRect = CGRect(x: 0, y: 0, width: radius * 2 * XScale, height: radius * 2 * YScale)
        // create uibezierpath of circle that fits in rect
        let circlePath = UIBezierPath(ovalInRect: circleRect)
        // create shape layer + properties
        let circleLayer = CAShapeLayer()
        circleLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        circleLayer.bounds = circleRect
        circleLayer.position = CGPoint(x: coords.x * XScale, y: coords.y * YScale)
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.lightYellow().CGColor
        
        return circleLayer
    }

}