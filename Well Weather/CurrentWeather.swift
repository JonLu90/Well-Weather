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
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON {  response in
            if let json = response.result.value as? [String: Any] {
                
                if let name = json["name"] as? String {
                    self._cityName = name
                }
                if let weather = json["weather"] as? [[String: Any]] {
                    if let mainWeather = weather[0]["main"] as? String {
                        self._weatherType = mainWeather
                    }
                }
                if let main = json["main"] as? [String: Any] {
                    if let kelvin = main["temp"] as? Double {
                        let farenheit = self.kelvinToFarenheit(kelvin: kelvin)
                        self._currentTemp = farenheit
                    }
                }
            } else {
                print("Error: \(response.error)")
            }
            completed()
        }
        
    }
    
    func kelvinToFarenheit(kelvin: Double) -> Double {
        let temp = kelvin * (9/5) - 459.67
        let farenheit = Double(round(10 * temp / 10))
        return farenheit
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
