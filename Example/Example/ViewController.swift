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
        
        let font = UIFont()
        let image = UIImage(named: "letter_background4")
        
        label = ScoreboardLabel(backgroundImage: image! ,text: "OUTSCORE", flipToText: "LOADING", font:font, textColor:UIColor.blackColor())
        
        view.addSubview(label)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

