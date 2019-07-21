//
//  WebViewController.swift
//  Top50FreeApps
//
//  Created by Aya Irshaid on 5/20/19.
//  Copyright © 2019 Aya Irshaid. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var appLink : URL?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load web request
        let myRequest = URLRequest(url: appLink!)
        webView.load(myRequest)
        
        
        // get progress estimation
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            
            // update progressView
            UIView.animate(withDuration: 0.05) {
                self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
            }
            
            // hide progressView when almost done
            if Float(webView.estimatedProgress) > 0.90 {
                self.progressView.isHidden = true
            }
        }
    }
    
}
