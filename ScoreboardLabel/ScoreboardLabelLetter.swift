//
//  ScoreboardLabelLetter.swift
//  Outscore
//
//  Created by Noam on 9/8/15.
//  Copyright (c) 2015 ICOgroup. All rights reserved.
//

import Foundation
import UIKit
import pop

enum Section {
    case Upper
    case Lower
}

protocol ScoreboardLabelLetterProtocol {
    
    func didFinishAnimatingLetter(letter: ScoreboardLabelLetter)
}

public class ScoreboardLabelLetter: UIView {
    
    var theNextLetter = ""
    var font : UIFont!
    var letterIndex = 0
    var delegate : ScoreboardLabelLetterProtocol?
    
    private var theFirstLetter = ""
    private var imageViewUpperHalf = UIImageView()
    private var imageViewLowerHalf = UIImageView()
    private var imageViewUpperHalfNextLetter = UIImageView()
    private var imageViewLowerHalfNextLetter = UIImageView()
    private var bottomShadowLayer = CAGradientLayer()
    private var topShadowLayer = CAGradientLayer()
    
    private var label = UILabel()
    private var imageview = UIImageView()
    
    //frames
    private var rectUpperHalf = CGRectZero
    private var rectLowerHalf = CGRectZero
    private var originUpperHalf = CGPointZero
    private var originLowerHalf = CGPointZero
    
    
    override init(frame:CGRect) {
        
        super.init(frame: frame)
        
        //frames
        rectUpperHalf = CGRectMake(0, 0, bounds.size.width, bounds.size.height * 0.5)
        rectLowerHalf = CGRectMake(0, frame.size.height * 0.5, frame.size.width, frame.size.height * 0.5)
        
        originUpperHalf = CGPointMake(0, frame.size.height * -0.01)
        originLowerHalf = CGPointMake(0, frame.size.height * 0.51)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderScoreboardLabelLetters(backgroundImage:UIImage, textColor:UIColor, letter:String, nextLetter:String) {
        
        backgroundColor = UIColor.clearColor()
        
        label.frame = bounds
        label.font = font
        label.textAlignment = NSTextAlignment.Center
        label.textColor = textColor
        
        label.text = letter
        
        imageview.frame = label.frame
        imageview.contentMode = UIViewContentMode.ScaleAspectFit
        imageview.image = backgroundImage
        imageview.clipsToBounds = true
        imageview.layer.borderColor = UIColor.blackColor().CGColor
        imageview.layer.borderWidth = 0.1
        
        imageview.addSubview(label)
        
        
        
        theNextLetter = nextLetter
        theFirstLetter = letter
        
        renderNextLetterImages()
        renderCurrentLetterImages()
    }
    
    
    /**
    life cycle:
    
    imageviews with next/empty letter
    
    imageviews with current letter
    
    set next letter to imageviews underneeth
    perform flip animation
    
    flip complete: remove current letter image views
    
    add Imageviews with currentLetter
    */
    
    
    
    
    
    func renderCurrentLetterImages() {
        
        imageViewUpperHalf = UIImageView(frame: rectUpperHalf)
        imageViewUpperHalf.layer.anchorPoint = CGPointMake(0.5, 1.02);
        imageViewUpperHalf.layer.position = CGPointMake(imageViewUpperHalf.frame.width * 0.5, imageViewUpperHalf.frame.height * 0.5)
        imageViewUpperHalf.layer.mask = maskForRectInSection(Section.Upper, rect: imageViewUpperHalf.bounds)
        imageViewUpperHalf.frame.origin = originUpperHalf
        
        imageViewUpperHalf.contentMode = UIViewContentMode.Center
        imageViewUpperHalf.backgroundColor = UIColor.grayColor()

        imageViewUpperHalf.layer.transform = transform3D()
        
        let imageTop = imageHalfForSection(Section.Upper, theView:imageview)
        imageViewUpperHalf.image = imageTop
        
        
        //top Shadow
        topShadowLayer.frame = imageViewUpperHalf.bounds
        topShadowLayer.colors = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
        topShadowLayer.opacity = 0
        
        imageViewUpperHalf.layer.addSublayer(topShadowLayer)

        
        
        imageViewLowerHalf = UIImageView(frame: rectLowerHalf)
        imageViewLowerHalf.frame.origin = originLowerHalf
        imageViewLowerHalf.layer.mask = maskForRectInSection(Section.Lower, rect: imageViewLowerHalf.bounds)
        
        imageViewLowerHalf.contentMode = UIViewContentMode.Center
        imageViewLowerHalf.backgroundColor = UIColor.grayColor()

        let imageBottom = imageHalfForSection(Section.Lower, theView:imageview)
        imageViewLowerHalf.image = imageBottom
        
        //bottom Shadow
        bottomShadowLayer.frame = imageViewLowerHalf.bounds
        bottomShadowLayer.colors = [UIColor.blackColor().CGColor, UIColor.clearColor().CGColor]
        bottomShadowLayer.opacity = 0
        
        imageViewLowerHalf.layer.addSublayer(bottomShadowLayer)
        
        addSubview(imageViewLowerHalf)
        addSubview(imageViewUpperHalf)
    }
    
    
    func renderNextLetterImages() {
        
        imageViewUpperHalfNextLetter.frame = rectUpperHalf
        imageViewUpperHalfNextLetter.frame.origin = originUpperHalf
        imageViewUpperHalfNextLetter.contentMode = UIViewContentMode.Center
        imageViewUpperHalfNextLetter.backgroundColor = UIColor.grayColor()
        imageViewUpperHalfNextLetter.layer.mask = maskForRectInSection(Section.Upper, rect: imageViewUpperHalfNextLetter.bounds)
        
        imageViewLowerHalfNextLetter.frame = rectLowerHalf
        imageViewLowerHalfNextLetter.frame.origin = originLowerHalf
        imageViewLowerHalfNextLetter.contentMode = UIViewContentMode.Center
        imageViewLowerHalfNextLetter.backgroundColor = UIColor.grayColor()
        imageViewLowerHalfNextLetter.layer.mask = maskForRectInSection(Section.Lower, rect: imageViewLowerHalfNextLetter.bounds)

        addSubview(imageViewUpperHalfNextLetter)
        addSubview(imageViewLowerHalfNextLetter)
    }
    
    
    func prepareForNextLetter() {
        
        label.text = theNextLetter
        
        let imageTop = imageHalfForSection(Section.Upper, theView:imageview)
        imageViewUpperHalfNextLetter.image = imageTop

        let imageBottom = imageHalfForSection(Section.Lower, theView:imageview)
        imageViewLowerHalfNextLetter.image = imageBottom
    }
    
    func flipLetterAfterWait(wait:CFTimeInterval) {
        
        flipToLetterAfterWait(theNextLetter, wait: wait)
    }
    
    func flipToLetterAfterWait(letter:String, wait:CFTimeInterval)  {
        
        theNextLetter = letter
        
        prepareForNextLetter()
        
        let rotationAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotationX)
        rotationAnimation.springBounciness = 5.0
        rotationAnimation.dynamicsMass = 2.0
        rotationAnimation.dynamicsTension = 200
        
        
        rotationAnimation.toValue = 2.8
        rotationAnimation.delegate = self;
        rotationAnimation.beginTime = CACurrentMediaTime() + wait
//        print("\nbeginTime = \(rotationAnimation.beginTime)")
        rotationAnimation.completionBlock = {(animation, finished) in
            
            if (finished == true) {
                
                self.imageViewUpperHalf.layer.pop_removeAllAnimations()
                self.prepareForNextLetter()
                self.renderCurrentLetterImages()
            }
        }

        imageViewUpperHalf.layer.pop_addAnimation(rotationAnimation, forKey: "rotationAnimation")
    }
    
    
    func pop_animationDidApply(anim: POPAnimation!) {
        
        
        if let currentValue = anim.valueForKey("currentValue")?.floatValue {
            
            if (currentValue < 1.4) {
                
                CATransaction.begin()
                CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
                self.bottomShadowLayer.opacity = Float(currentValue)/Float(2.8)
                self.topShadowLayer.opacity = Float(currentValue)/Float(2.8)
                CATransaction.commit()
            }else if (currentValue > 1.4 && currentValue < 1.7) {
                
                imageViewLowerHalf.removeFromSuperview()


            }else {
                CATransaction.begin()
                CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
                self.bottomShadowLayer.opacity = 1 - Float(currentValue)/Float(2.8)
                self.topShadowLayer.opacity = 1 - Float(currentValue)/Float(2.8)
                CATransaction.commit()
            }
        }
        
    }
    
    func removeImageViews() {
        
        imageViewUpperHalf.removeFromSuperview()
    }
    
    func pop_animationDidReachToValue(anim: POPAnimation!) {
        
        self.label.text = theNextLetter
        removeImageViews()
        delegate?.didFinishAnimatingLetter(self)
    }
    
    func imageHalfForSection(section:Section ,theView:UIView) -> UIImage {
        
        //taking a snapShot
        UIGraphicsBeginImageContext(theView.frame.size)
        theView.layer.renderInContext(UIGraphicsGetCurrentContext())
        var screenShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //returning only upper half
        let rect = (section == Section.Upper) ? CGRectMake(0, 0, theView.frame.size.width, theView.frame.size.height * 0.5) : CGRectMake(0, theView.frame.size.height * 0.5, theView.frame.size.width, theView.frame.size.height * 0.5)
        
        
        let imageRef = CGImageCreateWithImageInRect(screenShot.CGImage, rect)
        let half = UIImage(CGImage: imageRef)
        
        return half!
    }
    
    
    
    func transform3D() ->CATransform3D {
        
        var transform = CATransform3DIdentity
        transform.m34 = CGFloat(2.5) / CGFloat(500)
        return transform
    }
    
    
    func maskForRectInSection(section:Section ,rect:CGRect) -> CAShapeLayer {
        
        let layerMask = CAShapeLayer()
        let corners = (section == Section.Upper) ? UIRectCorner.TopLeft | UIRectCorner.TopRight : UIRectCorner.BottomLeft | UIRectCorner.BottomRight
        layerMask.path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSizeMake(5, 5)).CGPath
        
        return layerMask
    }
    
}

















