import UIKit

// Custom UITableViewCell for a side menu, renamed as DrawerCell
class DrawerCell: UITableViewCell {
    
    // Identifier for reusing the cell
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // Nib file for loading the cell
    class var cellNib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    // Outlets for the cell's title label and icon image view
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // Called when the cell is loaded from the nib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the background color to clear
        self.backgroundColor = .clear
        
        // Configure icon appearance
        self.iconImageView.tintColor = .white
        
        // Set title label color
        self.titleLabel.textColor = .white
    }

    // Called when the cell's selection state changes
    override func setSelected(_ isSelected: Bool, animated: Bool) {
        super.setSelected(isSelected, animated: animated)
        
        // Configure the view for the selected state (currently default behavior)
    }
}
