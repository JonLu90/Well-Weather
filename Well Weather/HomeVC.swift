import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Well Weather"
        setupUI()
        
        view.backgroundColor = UIColor.blue
        
        tableView.dataSource = self
        tableView.delegate = self
        
        print(CURRENT_WEATHER_URL)
        currentWeather.downloadWeatherDetails {
            // TODO
            // update UI
        }
    }
    
    var currentWeather = CurrentWeather()
    
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
        label.sizeToFit()
        label.text = "70.3"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "weather cell", for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
}
