//
//  Location.swift
//  Pretty Cloudy
//
//  Created by DevX on 4/15/17.
//  Copyright © 2017 DevSwift__. All rights reserved.
//

import Foundation
class Location {
    static var sharedlocation = Location()
    
    private init(){
        
    }
    var Lat:Double!
    var long:Double!
}
