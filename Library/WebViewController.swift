//
//  WebViewController.swift
//  Library
//
//  Created by Jason on 8/17/15.
//  Copyright © 2015 IIT. All rights reserved.
//

import UIKit

class WebVIewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://gl.iit.edu");
        let requestobject = NSURLRequest(URL: url!);
        webView.loadRequest(requestobject)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
