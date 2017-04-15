//
//  weatherCurrent.swift
//  Pretty Cloudy
//
//  Created by DevX on 4/13/17.
//  Copyright © 2017 DevSwift__. All rights reserved.
//

import Foundation
import Alamofire
class WeatherCurrent{
    
    var foreCasts:[ForeCast] = [ForeCast]()
    
    private var _City:String!
    var city:String{
            return _City
    }
    private var _Date:String!
    var date:String{
        if _Date != nil{
            _Date = ""
        }
        let dFormat = DateFormatter()
        dFormat.dateStyle = .short
        dFormat.timeStyle = .none
        _Date = dFormat.string(from: Date())
        
        return "Today: \(_Date!)"
    }
    private var _Temp:Double!
    var temp:Double{
        return _Temp
    }
    private var _Htemp:Double!
    var htemp:Double{
        return _Htemp
    }
    private var _Ltemp:Double!
    var ltemp:Double{
        return _Ltemp
    }

    private var _Desc:String!
    var desc:String{
        return _Desc
    }
    private var _ImageStatus:UIImage!
    var imageStatus:UIImage!{
        get{
            if _ImageStatus == nil{
                _ImageStatus = UIImage(named: "Clear.png")
            }
            return _ImageStatus
        }
    }
    
    func GetCurrentWeather(completed:@escaping DownloadComplete){
        print(CURRENT_WEATHER_URL)
        
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON{ response in
            if let dict = response.value as? Dictionary<String,AnyObject>{
                if let nameCity = dict["name"] as? String{
                    self._City = nameCity
                }
                if let weatherDict = dict["weather"] as? [Dictionary<String,AnyObject>]{
                    if let main = weatherDict[0]["main"] as? String {
                        self._Desc = main
                        self._ImageStatus = UIImage(named: main)
                    }
                }
                if let mainDict = dict["main"] as? Dictionary<String,AnyObject>{
                    if let temp = mainDict["temp"] as? Double{
                        let kelvinToFarenheitPreDivision = (temp * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                        self._Temp = kelvinToFarenheit
                    }
                    if let temp_min = mainDict["temp_min"] as? Double{
                        let kelvinToFarenheitPreDivision = (temp_min * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                        self._Ltemp = kelvinToFarenheit
                    }
                    if let temp_max = mainDict["temp_max"] as? Double {
                        let kelvinToFarenheitPreDivision = (temp_max * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                        self._Htemp = kelvinToFarenheit
                    }
                }
            }            
            completed()
        }
    }
}
