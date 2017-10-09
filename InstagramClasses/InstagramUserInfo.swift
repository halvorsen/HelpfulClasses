//
//  InstagramUserInfo.swift
//  cull
//
//  Created by Aaron Halvorsen on 10/6/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit
import CoreData

class InstagramUserInfo: NSManagedObject {

    func saveToCoreData(_ data: DailyInstagramData) {
        let container = AppDelegate.persistentContainer
        container.performBackgroundTask { context in
            let instagramUserInfo = InstagramUserInfo(context: context)
            instagramUserInfo.date = data.date as NSDate?
            instagramUserInfo.followers = data.followers ?? 0
            instagramUserInfo.following = data.following ?? 0
            instagramUserInfo.mediaCount = data.mediaCount ?? 0
            try? context.save()
        }
        
    }
    
}
