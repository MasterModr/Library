//
//  ViewController.swift
//  Library
//
//  Created by Jason on 8/11/15.
//  Copyright © 2015 IIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var map1: UIImageView!
    @IBOutlet weak var map2: UIImageView!
    var image = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tiled.png")!);
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonPressed(sender: AnyObject) {
        if image == 0{
            map1.hidden = true
            map2.hidden = false
            image = 1
        }
        else{
            map1.hidden = false
            map2.hidden = true
            image = 0
        }
    
    }
    
    

}

