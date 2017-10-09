//
//  InstagramMediaInfo.swift
//  cull
//
//  Created by Aaron Halvorsen on 10/6/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit
import CoreData

class InstagramMediaInfo: NSManagedObject {
    //TODO overwrite duplicated media with identical Dates
    func saveToCoreData(_ data: [DailyInstagramData]) {
        let container = AppDelegate.persistentContainer
        container.performBackgroundTask { context in
            //downloading current managed objects, entire set of them to be compared and deleted if needed
            var allObjects = [InstagramMediaInfo]()
            let request : NSFetchRequest<InstagramMediaInfo> = InstagramMediaInfo.fetchRequest()
            if let matches = try? context.fetch(request) {
                allObjects = matches
            }
            
            for dailyData in data {
                
                //checks to see if media record already exists and deletes it to then be replaced with updated likes and comments
                if let uniqueID = dailyData.uniqueID {
                    for instagramObject in allObjects {
                        if instagramObject.uniqueID == uniqueID {
                            context.delete(instagramObject)
                        }
                    }
                }
                
                let instagramMediaInfo = InstagramMediaInfo(context: context)
                instagramMediaInfo.date = dailyData.date as NSDate?
                instagramMediaInfo.likes = dailyData.likes ?? 0
                instagramMediaInfo.comments = dailyData.comments ?? 0
            }
            try? context.save()
        }
    }
}
