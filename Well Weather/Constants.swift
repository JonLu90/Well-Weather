
import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat=36"
let LONGITUDE = "&lon=100"
let APP_ID = "&appid="
let API_KEY = "e26d4563c5da92bad56b42282088a521"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"

typealias DownloadComplete = () -> ()
