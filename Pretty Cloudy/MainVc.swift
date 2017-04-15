//
//  MainVc.swift
//  Pretty Cloudy
//
//  Created by DevX on 4/13/17.
//  Copyright © 2017 DevSwift__. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
class MainVc: UIViewController,UITableViewDataSource,UITableViewDelegate ,CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var _WeatherCurrent:WeatherCurrent!
    var foreCasts = [ForeCast]()
    
    var locationManager = CLLocationManager()
    //var currentLocation = CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _WeatherCurrent = WeatherCurrent()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setLocation()
    }
    func setLocation(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            if let currentLocation = locationManager.location{
                Location.sharedlocation.Lat = currentLocation.coordinate.latitude
                Location.sharedlocation.long = currentLocation.coordinate.longitude
                print(Location.sharedlocation.Lat)
                print(Location.sharedlocation.long)
                _WeatherCurrent.GetCurrentWeather{
                    self.DownloadForceCast(completed: self.UpdateMainUI)
                }
            }
            
        }
        else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    func DownloadForceCast(completed:@escaping DownloadComplete){
        Alamofire.request(ForeCast_URL).responseJSON{response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = ForeCast(weatherDict: obj)
                        self.foreCasts.append(forecast)
                        print(obj)
                    }
                    self.foreCasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }

    }
    //*******************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foreCasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell{
            /*var w:ForeCast = Weather(Day: "Sunday", HDegree: 70, LDegree: 12, ImageCode: "Clear",Status: "Clear")
            */
            cell.UpdateUI(_weather: foreCasts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    //*******************
    
    
    func UpdateMainUI() -> (){
        lblCityName.text = _WeatherCurrent.city
        lblDate.text = "\(_WeatherCurrent.date)"
        imageStatus.image = _WeatherCurrent.imageStatus
        lblStatus.text = _WeatherCurrent.desc
        lblTemp.text = "\(_WeatherCurrent.temp)°"
        lblHtemp.text = "\(_WeatherCurrent.htemp)°"
        lblLtemp.text = "\(_WeatherCurrent.ltemp)°"
        
        
    }
        
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblHtemp: UILabel!
    @IBOutlet weak var lblLtemp: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imageStatus: UIImageView!
    
}

