//
//  File.swift
//  Pretty Cloudy
//
//  Created by DevX on 4/13/17.
//  Copyright © 2017 DevSwift__. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "ec58225e326675425ebb94ef8e3ca0c0"

typealias DownloadComplete = ()->()
let LatCairoLocation = 30
let LongCairoLocation = 31
let CURRENT_WEATHER_URL = BASE_URL+LATITUDE+"\(Location.sharedlocation.Lat!)"+LONGITUDE+"\(Location.sharedlocation.long!)"+APP_ID+API_KEY
let ForeCast_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedlocation.Lat!)&lon=\(Location.sharedlocation.long!)&cnt=10&appid=ec58225e326675425ebb94ef8e3ca0c0"
