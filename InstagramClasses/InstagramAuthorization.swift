//
//  InstagramAuthorization.swift
//  cull
//
//  Created by Aaron Halvorsen on 10/5/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import Foundation
import InstagramKit


class InstagramAuthorization {
    
    func instagramAuthenticate() -> URLRequest {
        
        let authURL = InstagramEngine.shared().authorizationURL()
        return URLRequest(url: authURL)
        
    }
    
}
