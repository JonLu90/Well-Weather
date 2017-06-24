import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    func configureCell(forecast: Forecast) {
        lowTempLabel.text = forecast.lowTemp
        highTempLabel.text = forecast.highTemp
        cellWeatherLabel.text = forecast.weather
        cellWeatherImageView.image = UIImage(named: forecast.weather)
        cellDateLabel.text = forecast.date
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setCellUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }()
    
    let cellWeatherLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()

        
        return label
    }()
    
    let highTempLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }()
    
    let lowTempLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let cellWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFit

        return imageView
    }()
    
    func setCellUI() {
        let cellStackViewLeft = UIStackView()
        cellStackViewLeft.backgroundColor = UIColor.red
        cellStackViewLeft.addArrangedSubview(cellDateLabel)
        cellStackViewLeft.addArrangedSubview(cellWeatherLabel)
        cellStackViewLeft.axis = UILayoutConstraintAxis.vertical
        cellStackViewLeft.distribution = .fillEqually
        cellStackViewLeft.spacing = 8
        cellStackViewLeft.translatesAutoresizingMaskIntoConstraints = false
        
        let cellStackViewRight = UIStackView()
        cellStackViewRight.backgroundColor = UIColor.red
        cellStackViewRight.addArrangedSubview(highTempLabel)
        cellStackViewRight.addArrangedSubview(lowTempLabel)
        cellStackViewRight.axis = UILayoutConstraintAxis.vertical
        cellStackViewRight.distribution = .fillEqually
        cellStackViewRight.spacing = 8
        cellStackViewRight.translatesAutoresizingMaskIntoConstraints = false
        
        let cellStackView = UIStackView()
        cellStackView.backgroundColor = UIColor.red
        cellStackView.addArrangedSubview(cellStackViewLeft)
        cellStackView.addArrangedSubview(cellWeatherImageView)
        cellStackView.addArrangedSubview(cellStackViewRight)
        cellStackView.axis = UILayoutConstraintAxis.horizontal
        cellStackView.distribution = .fillEqually
        cellStackView.spacing = 16
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // set constraints for weatherCellImageView
        
        
        contentView.addSubview(cellStackView)
        cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        contentView.bottomAnchor.constraint(equalTo: cellStackView.bottomAnchor, constant: 8).isActive = true
        cellStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        contentView.rightAnchor.constraint(equalTo: cellStackView.rightAnchor, constant: 8).isActive = true
        
    }
    
    
    
    
    
}
