//
//  DetailsViewController.swift
//  Top50FreeApps
//
//  Created by Aya Irshaid on 5/19/19.
//  Copyright © 2019 Aya Irshaid. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var appViewModel : AppViewModel?
    var enlargeImage = Bool()
    
//    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var appLinkButton: UIButton!
    @IBOutlet weak var appImageView : UIImageView!
    @IBOutlet weak var appCopyrightLabel : UILabel!
    @IBOutlet weak var appReleaseDateLabel : UILabel!
    @IBOutlet weak var appKindLabel : UILabel!
    
    @IBOutlet weak var appImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var appImageWidthConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set page title
        self.navigationItem.title = appViewModel?.appName
        
        // add GestureRecognizer to enlarge or reduce app's image view
        let tapEnlargeReduceGR = UITapGestureRecognizer(target: self, action: #selector(enlargeOrReduceImage))
        appImageView.isUserInteractionEnabled = true
        appImageView.addGestureRecognizer(tapEnlargeReduceGR)
        
        
        // set label's data
        appLinkButton.setTitle(appViewModel?.stringAppURL, for: .normal)
        appKindLabel.text = appViewModel?.kind
        appCopyrightLabel.text = appViewModel?.copyright
        appReleaseDateLabel.text = appViewModel?.releaseDate
        
        
        // load image
        if let appImageUrl = appViewModel?.imageURL {
            self.appImageView?.loadImageUsingCacheWithUrlString(urlString: appImageUrl)
            
        }
    }
    
    @objc func enlargeOrReduceImage(_ sender: UITapGestureRecognizer){
        
        enlargeImage = !enlargeImage
        var newFrame : CGRect?
        
        // chek whether to enlarge or reduce the image view, then set the new frame based on which
        if enlargeImage {
           
            newFrame = CGRect(x: appImageView.frame.origin.x - 50, y: appImageView.frame.origin.y - 50, width: appImageView.frame.width + 100, height: appImageView.frame.height + 100)
        }else{
            newFrame = CGRect(x: appImageView.frame.origin.x + 50, y: appImageView.frame.origin.y + 50, width: appImageView.frame.width - 100, height: appImageView.frame.height - 100)
        }
        
        // set the new frame of image view
        UIView.animate(withDuration: 0.70, animations: {
            self.appImageView.frame = newFrame!
            self.view.setNeedsDisplay()
        })
       
    }
    
    @IBAction func appLinkTapped(_ sender: Any) {
        
        // get 'WebViewController' from storyboard
        let webVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController
        
        // set its data
        webVC!.appLink = appViewModel?.appURL
        
        // show the view
        self.navigationController?.pushViewController(webVC!, animated: true)
    }
    
}

