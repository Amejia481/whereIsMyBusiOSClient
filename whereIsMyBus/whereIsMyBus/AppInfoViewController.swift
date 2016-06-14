//
//  SecondViewController.swift
//  whereIsMyBus
//
//  Created by Administrator on 5/23/16.
//  Copyright © 2016 Administrator. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView: UIWebView = UIWebView.init(frame: CGRectZero);
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSBundle.mainBundle().URLForResource("whereismybusinfo/index", withExtension:"html") 
        let requestObj = NSURLRequest(URL: url!);
    
       webView.loadRequest(requestObj);
        self.view = webView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

