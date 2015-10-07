//
//  ViewController.swift
//  Example
//
//  Created by Noam on 9/30/15.
//  Copyright (c) 2015 Noam. All rights reserved.
//

import UIKit
import ScoreboardLabel


class ViewController: UIViewController {
    
    var label : ScoreboardLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let font = UILabel().font
        let image = UIImage(named: "letter_background4")
        
        label = ScoreboardLabel(backgroundImage: image! ,text: "SCOREBOARD", flipToText: "LOADING", font:font, textColor:UIColor.blackColor())
        
        label.interval = Double(0.4)
        
        label.completionHandler = { (finished:Bool) in
            if finished == true {
                self.label.hidden = true
            }
        }
        
        label.center = view.center
        
        view.addSubview(label)
        
        
        //stop start button
        let button = UIButton(type: UIButtonType.System)
        button.titleLabel?.font = font
        button.setTitle("Start", forState: UIControlState.Normal)
        button.setTitle("Stop", forState: UIControlState.Selected)
        button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        button.sizeToFit()
        button.center = CGPointMake(view.center.x, view.center.y * 1.3)
        
        view.addSubview(button)
    }
    
    
    func buttonPressed(button:UIButton) {
        
        if button.selected == true { //stop
            
            label.stopFlipping()
            
        }else { //start
            
            label.hidden = false
            label.flip(true)
        }
        
        button.selected = !button.selected
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
















