import UIKit
import Alamofire

class CurrentWeather {
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0
        }
        return _currentTemp
    }
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!

    func downloadWeatherDetails(completed: DownloadComplete) {
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON {  response in
            if let json = response.result.value {
                print("JSON : \(json)")
            } else {
                print("error!")
            }
            print(response)
        }
        completed()
    }















}
