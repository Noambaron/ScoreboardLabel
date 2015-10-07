//
//  ScoreboardLabel.swift
//  Outscore
//
//  Created by Noam on 9/9/15.
//  Copyright (c) 2015 ICOgroup. All rights reserved.
//

import Foundation
import UIKit


public class ScoreboardLabel: UIView, ScoreboardLabelLetterProtocol {
    
    public var firstText = ""
    public var secondText = ""
    public var textFont : UIFont!
    public var textColor: UIColor!
    public var interval = CFTimeInterval(0.3)
    public var isRepeating = true
    
    var firstWordLetters = Array<String>()
    var secondWordLetters = Array<String>()
    
    var flippingLetters = Array<ScoreboardLabelLetter>()

    public var completionHandler:((Bool)->Void)!
    
    private var showingFirstWord = true
    
    override init(frame:CGRect) {
        
        super.init(frame: frame)
        clipsToBounds = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience public init(backgroundImage:UIImage ,text:String, flipToText:String, font:UIFont, textColor:UIColor) {
        
        let maxChars = max(text.Letterize().count, flipToText.Letterize().count)
        let rect = CGRectMake(0, 0, CGFloat(maxChars) * CGFloat(font.pointSize), CGFloat(font.pointSize) * CGFloat(1.5))
        
        self.init (frame:rect)
        
        textFont = font
        self.textColor = textColor
        firstWordLetters = text.Letterize()
        secondWordLetters = flipToText.Letterize()
        
        firstText = text
        secondText = flipToText
        
        var lastOriginX = CGFloat(0)
        let height = textFont.pointSize * 1.5
        let width = textFont.pointSize
        
        //build flipping letters
        for index in 1...maxChars {
            
            let frameForLetter = CGRectMake(lastOriginX, 0, width, height)
            let flipLetter = ScoreboardLabelLetter(frame: frameForLetter)
            flipLetter.font = textFont
            flipLetter.letterIndex = index
            flipLetter.delegate = self
            
            var firstLetter = ""
            var secondLetter = ""
            
            if let letter = firstWordLetters.get(index - 1) {
                
                firstLetter = letter
            }
            if let otherLetter = secondWordLetters.get(index - 1) {
                
                secondLetter = otherLetter
            }
            flipLetter.renderScoreboardLabelLetters(backgroundImage, textColor:textColor,letter: firstLetter, nextLetter: secondLetter)
            
            flippingLetters.append(flipLetter)
            
            addSubview(flipLetter)
            
            lastOriginX += width + 5
        }
    }
    
    
    public func flip(continuosly: Bool) {
        
        isRepeating = continuosly
        flipLetterAtIndex(0)
    }
    
    public func stopFlipping() {
        
        isRepeating = false
    }
    
    func flipLetterAtIndex(index:Int) {
        
        if (index > flippingLetters.count - 1) {
            showingFirstWord = !showingFirstWord
            return
        }
        let viewLetter = flippingLetters[index]
        
        let letter = (showingFirstWord == true) ? secondWordLetters.get(index) : firstWordLetters.get(index)
        if let letter = letter {
            viewLetter.flipToLetterAfterWait(letter, wait: interval * CFTimeInterval(index))
        }else {
            viewLetter.flipToLetterAfterWait("", wait: interval * CFTimeInterval(index))
        }
        flipLetterAtIndex(index + 1)
    }
    
    func didFinishAnimatingLetter(letter: ScoreboardLabelLetter) {
        
        if (letter.letterIndex == flippingLetters.count && isRepeating == true) { //it was the last letter and we need to repeat
            performThisAfter(0.8, closure: { () -> () in
                self.flipLetterAtIndex(0)
            })
        }else if letter.letterIndex == flippingLetters.count {
            
            if completionHandler != nil {
                completionHandler(true)
            }
        }
    }
}


















