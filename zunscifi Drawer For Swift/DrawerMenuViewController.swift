import UIKit

// Delegate protocol for handling cell selection
protocol DrawerMenuViewControllerDelegate {
    func didSelectCell(at row: Int)
}

// Custom view controller for the drawer menu
class DrawerMenuViewController: UIViewController {
    
    // Outlets for the header image, menu table, and footer label
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var menuTableView: UITableView!
    @IBOutlet var footerLabel: UILabel!
    
    // Delegate for handling menu selections
    var delegate: DrawerMenuViewControllerDelegate?
    
    // Default cell to highlight when the view loads
    var defaultHighlightedCell: Int = 0
    
    // Menu data containing icons and titles
    var menuItems: [DrawerMenuModel] = [
        DrawerMenuModel(icon: UIImage(systemName: "heart")!, title: "Item 1"),
        DrawerMenuModel(icon: UIImage(systemName: "heart")!, title: "Item 2"),
        DrawerMenuModel(icon: UIImage(systemName: "heart")!, title: "Item 3"),
        DrawerMenuModel(icon: UIImage(systemName: "heart")!, title: "Item 4"),
        DrawerMenuModel(icon: UIImage(systemName: "heart")!, title: "Item 5"),
        DrawerMenuModel(icon: UIImage(systemName: "heart")!, title: "Item 6")
    ]
    
    // Lifecycle method called after the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup for the table view
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuTableView.backgroundColor = .white
        self.menuTableView.separatorStyle = .none
        
        // Footer configuration
        self.footerLabel.textColor = .white
        self.footerLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.footerLabel.text = "Version 1.1"
        
        // Register the custom cell for the table view
        self.menuTableView.register(DrawerCell.cellNib, forCellReuseIdentifier: DrawerCell.reuseIdentifier)
        
        // Update the table view with the data
        self.menuTableView.reloadData()
        
        // Set header image
        self.headerImageView.image = UIImage(named: "img3")
    }
}

// MARK: - UITableViewDelegate

extension DrawerMenuViewController: UITableViewDelegate {
    // Set the height for each row in the table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

// MARK: - UITableViewDataSource

extension DrawerMenuViewController: UITableViewDataSource {
    // Return the number of rows based on the menu items
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    // Configure each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrawerCell.reuseIdentifier, for: indexPath) as? DrawerCell else {
            fatalError("DrawerCell nib doesn't exist")
        }
        
        // Configure the cell with icon and title
        cell.iconImageView.image = self.menuItems[indexPath.row].icon
        cell.iconImageView.tintColor = .black
        cell.titleLabel.text = self.menuItems[indexPath.row].title
        cell.titleLabel.textColor = .black
        
        // Set custom selection background color
        let customSelectionColorView = UIView()
        customSelectionColorView.backgroundColor = .white
        cell.selectedBackgroundView = customSelectionColorView
        return cell
    }
    
    // Handle cell selection and notify the delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectCell(at: indexPath.row)
    }
}
