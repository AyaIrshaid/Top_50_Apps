//
//  Service.swift
//  Top50FreeApps
//
//  Created by Aya Irshaid on 7/21/19.
//  Copyright © 2019 Aya Irshaid. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


class DataService {
    
    
    public static func fetchAppData(completionHandler: @escaping ([AppViewModel])-> Void){
        
        //
        let URL_GET_DATA = "https://rss.itunes.apple.com/api/v1/jo/ios-apps/top-free/all/50/explicit.json"
        var appViewModels = [AppViewModel]()
        
        //
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            // getting json
            if let json = response.result.value as? NSDictionary {
                
                let results = json.value(forKeyPath: "feed.results") as! NSArray
                
                // get apps
                for result in results{
                    
                    // create model instance
                    let app = AppData(
                        name: (result as AnyObject).value(forKey: "name") as! String,
                        artworkUrl100 : (result as AnyObject).value(forKey: "artworkUrl100") as! String,
                        url : (result as AnyObject).value(forKey: "url") as! String,
                        copyright: (result as AnyObject).value(forKey: "copyright") as! String,
                        releaseDate: (result as AnyObject).value(forKey: "releaseDate") as! String,
                        kind: (result as AnyObject).value(forKey: "kind") as! String
                    )
                    
                    // append viewModel to the array
                    appViewModels.append(AppViewModel(appData: app))
                }
                
                //
                completionHandler(appViewModels)
            }
        }
    }
}
