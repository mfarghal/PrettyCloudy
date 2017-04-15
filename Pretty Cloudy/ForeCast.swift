//
//  ForeCast.swift
//  Pretty Cloudy
//
//  Created by DevX on 4/15/17.
//  Copyright © 2017 DevSwift__. All rights reserved.
//

import UIKit
import Alamofire

class ForeCast {
    private var _Day:String!
    private var _HDegree:String!
    private var _LDegree:String!
    private var _Img:UIImage!
    private var _Status:String!
    
    var Day:String{
        return _Day
    }
    var HDegree:String{
        return _HDegree
    }
    var LDegree:String{
        return _LDegree
    }
    var Image:UIImage{
        return _Img
    }
    var Status:String{
        return _Status
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double {
                let kelvinToFarenheitPreDivision = (min * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                self._LDegree = "\(kelvinToFarenheit)"
            }
            if let max = temp["max"] as? Double {
                let kelvinToFarenheitPreDivision = (max * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                self._HDegree = "\(kelvinToFarenheit)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self._Status = main
                if let img = UIImage(named: _Status){
                    _Img = img
                }
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._Day = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
