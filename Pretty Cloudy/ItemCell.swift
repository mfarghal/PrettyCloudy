//
//  ItemCell.swift
//  Pretty Cloudy
//
//  Created by DevX on 4/13/17.
//  Copyright © 2017 DevSwift__. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var WeatherDay: UILabel!
    @IBOutlet weak var WeatherImage: UIImageView!
    @IBOutlet weak var WeatherHDegree: UILabel!
    @IBOutlet weak var WeatherLDegree: UILabel!
    
    func UpdateUI(_weather:ForeCast){
        WeatherDay.text = _weather.Day
        WeatherHDegree.text = "\(_weather.HDegree)°"
        WeatherLDegree.text = "\(_weather.LDegree)°"
        WeatherImage.image = _weather.Image
    }
    
}
