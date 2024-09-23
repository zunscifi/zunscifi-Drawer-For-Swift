import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var MENU: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        MENU.target = getDrawerController()
        MENU.action = #selector(getDrawerController()?.toggleMenu)
        // Do any additional setup after loading the view.
    }


}

