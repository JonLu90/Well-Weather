import UIKit
import Alamofire
import CoreLocation

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationAuthStatus()
        self.title = "Well... Ugly Weather"
        setupUI()
        
        view.backgroundColor = UIColor.blue
        
        tableView.dataSource = self
        tableView.delegate = self
        
        currentWeather = CurrentWeather()
        forecasts = [Forecast]()
        
        currentWeather.downloadWeatherDetails {
            self.updateWeatherUIInfo()
        }
        downloadForecastData {
            self.tableView.reloadData()
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts: [Forecast]!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.gray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let weatherMainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.yellow
        label.sizeToFit()
        label.text = "Today, July 26, 2016"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.yellow
        label.text = "70.3"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(48)
        
        return label
    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        return imageView
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.sizeToFit()
        label.text = "New York, New York"
        
        return label
    }()
    
    func updateWeatherUIInfo() {
        dateLabel.text = currentWeather.date
        temperatureLabel.text = "\(currentWeather.currentTemp)"
        locationLabel.text = currentWeather.cityName
        weatherImageView.image = UIImage(named: currentWeather.weatherType)
    }
    
    func setupUI() {
        
        let stackView = UIStackView()  // for weatherimageview and temperatureLabel
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        view.addSubview(weatherMainView)
        weatherMainView.addSubview(dateLabel)
        weatherMainView.addSubview(locationLabel)
        weatherMainView.addSubview(stackView)
        
        // table view always stand for lower half of the whole view
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": tableView]))
        view.addConstraints([NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: tableView, attribute: .bottom, multiplier: 1, constant: 16)])
        view.addConstraints([NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0)])
        
        // weatherMainView take upper half of the main view
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": weatherMainView]))
        view.addConstraints([NSLayoutConstraint(item: weatherMainView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 64)])
        view.addConstraints([NSLayoutConstraint(item: weatherMainView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0)])
        
        // set constraints for dateLabel
        weatherMainView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dateLabel]))
        weatherMainView.addConstraints([NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: weatherMainView, attribute: .top, multiplier: 1, constant: 8)])
        weatherMainView.addConstraints([NSLayoutConstraint(item: dateLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 20)])
        
        
        
        // set constraints for locationLabel
        locationLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: weatherMainView.leftAnchor, constant: 8).isActive = true
        weatherMainView.rightAnchor.constraint(equalTo: locationLabel.rightAnchor, constant: 8).isActive = true
        weatherMainView.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8).isActive = true
        
        // create stackview and add weatherimageview, temperatureLabel
        // then set constraints
        stackView.axis = UILayoutConstraintAxis.horizontal
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(weatherImageView)
        stackView.distribution = UIStackViewDistribution.fillEqually
        stackView.spacing = 8
        stackView.sizeToFit()
        stackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8).isActive = true
        locationLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16).isActive = true
        stackView.leftAnchor.constraint(equalTo: weatherMainView.leftAnchor, constant: 8).isActive = true
        weatherMainView.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 8).isActive = true
        
        // set up tableview cell
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "weather cell")
    }
    
    // table view datasource and delegation
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weather cell", for: indexPath) as? WeatherTableViewCell {
            cell.selectionStyle = .none
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            print(self.forecasts)
            return cell
        }
        else {
            return WeatherTableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        // download forecast weather data for tableview
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? [String: AnyObject] {
                if let list = dict["list"] as? [[String: AnyObject]] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    print(self.forecasts)
                }
            }
            completed()
        }
        print(FORECAST_URL)
    }
    
    // ask for location request permission
    // and assign geo-location info
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
        }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
}
