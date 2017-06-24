import UIKit
import Alamofire

class Forecast {
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weather: String {
        if _weather == nil {
            _weather = ""
        }
        return _weather
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: [String: AnyObject]) {
        if let temp = weatherDict["temp"] as? [String: AnyObject] {
            if let min = temp["min"] as? Double {
                let lowTempAsFarenheit = kelvinToFarenheit(kelvin: min)
                _lowTemp = "\(lowTempAsFarenheit)"
            }
            if let max = temp["max"] as? Double {
                let maxTempAsFarenheit = kelvinToFarenheit(kelvin: max)
                _highTemp = "\(maxTempAsFarenheit)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [[String: AnyObject]] {
            if let main = weather[0]["main"] as? String {
                _weather = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            _date = unixConvertedDate.WWDayOfTheWeek()
        }
    }
    
    var _date: String!
    var _weather: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    func kelvinToFarenheit(kelvin: Double) -> Double {
        let temp = kelvin * (9/5) - 459.67
        let farenheit = Double(round(10 * temp / 10))
        return farenheit
    }
    
}

extension Date {
    func WWDayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

