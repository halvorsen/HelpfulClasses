//
//  File.swift
//  cull
//
//  Created by Aaron Halvorsen on 10/6/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import Foundation

struct DailyInstagramData {
    
    let date : Date?
    let followers : Int64?
    let following : Int64?
    let mediaCount : Int64?
    let likes : Int64?
    let comments : Int64?
    var uniqueID : String? {
        print("Date Description: \(date?.description)")
       return date?.description
    }
    
}
