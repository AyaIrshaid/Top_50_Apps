//
//  ViewModel.swift
//  Top50FreeApps
//
//  Created by Aya Irshaid on 5/19/19.
//  Copyright © 2019 Aya Irshaid. All rights reserved.
//

import UIKit


struct AppViewModel{
    
    
    // private data model
    fileprivate var appData: AppData
    
    
    //
    init(appData : AppData) {
        self.appData = appData
    }
    
    
    // convert parameters of 'apppData' into readable form
    lazy var appName : String = {
        return appData.name
    }()
    
    lazy var imageURL : URL = {
        return URL(string: appData.artworkUrl100)!
    }()
    
    lazy var appURL : URL = {
        return URL(string: appData.url)!
    }()
    
    lazy var stringAppURL : String = {
        return appData.url
    }()
    
    lazy var copyright : String = {
        return appData.copyright
    }()
    
    lazy var releaseDate : String = {
        return appData.releaseDate
    }()
    
    lazy var kind : String = {
        return appData.kind
    }()
    
    
}

