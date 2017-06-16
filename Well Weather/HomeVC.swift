import UIKit

class HomeVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Well Weather"
        setupUI()
        
        view.backgroundColor = UIColor.blue
    }
    
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
    
    func setupUI() {
        
        view.addSubview(tableView)
        view.addSubview(weatherMainView)
        // table view always stand for lower half of the whole view
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": tableView]))
        view.addConstraints([NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: tableView, attribute: .bottom, multiplier: 1, constant: 16)])
        view.addConstraints([NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0)])

        // weatherMainView take upper half of the main view
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": weatherMainView]))
        view.addConstraints([NSLayoutConstraint(item: weatherMainView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 16)])
        view.addConstraints([NSLayoutConstraint(item: weatherMainView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0)])


    }
    
    
}
