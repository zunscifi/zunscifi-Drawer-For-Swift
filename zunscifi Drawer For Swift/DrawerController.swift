import UIKit

class DrawerController: UIViewController {
    
    // Reference to the side menu view controller
    public var menuViewController: DrawerMenuViewController!
    
    // Width of the side menu
    private var menuWidth: CGFloat = 260
    
    // Extra padding when the screen rotates
    private let rotationPadding: CGFloat = 150
    
    // State of the menu, whether it's visible or not
    public var menuIsVisible: Bool = false
    
    // Determines if the menu is displayed on top of the content
    private var menuOnTop: Bool = true
    
    // Shadow view behind the menu
    public var menuShadowView: UIView!
    
    // DrawerAnimator for animations
    private var drawerAnimator: DrawerAnimator!
    
    // DrawerGestureHandler for managing gestures
    private var gestureHandler: DrawerGestureHandler!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.375862439, blue: 1, alpha: 1)
        // Initialize the gesture handler
        gestureHandler = DrawerGestureHandler(controller: self)
        gestureHandler.addGestures(to: self.view)
        
        // Initialize the shadow view
        setupShadowView()
        
        // Initialize and add menu view controller
        setupMenuViewController()
        
        // Initialize the drawer animator
        drawerAnimator = DrawerAnimator(controller: self, menuWidth: menuWidth, menuOnTop: menuOnTop, rotationPadding: rotationPadding)
        
        // Show the initial home screen content
        displayContentController(viewController: UINavigationController.self, storyboardId: "MainViewController")
    }

    private func setupShadowView() {
        // Shadow view behind the menu
        menuShadowView = UIView(frame: self.view.bounds)
        menuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        menuShadowView.backgroundColor = .black
        menuShadowView.alpha = 0.0
        view.insertSubview(menuShadowView, at: menuOnTop ? 1 : 0)
    }

    private func setupMenuViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        menuViewController = storyboard.instantiateViewController(withIdentifier: "DrawerMenuViewController") as? DrawerMenuViewController
        menuViewController.defaultHighlightedCell = 0
        menuViewController.delegate = self
        view.insertSubview(menuViewController!.view, at: menuOnTop ? 2 : 0)
        addChild(menuViewController!)
        menuViewController!.didMove(toParent: self)
    }
    
    func displayContentController<T: UIViewController>(viewController: T.Type, storyboardId: String) {
        // Functionality to load and display the content view controller
        drawerAnimator.displayContentController(viewController: viewController, storyboardId: storyboardId)
    }
    
    // Function to toggle the menu (open/close)
    @IBAction open func toggleMenu() {
        setMenuState(visible: !menuIsVisible)
    }
    
    // Update the state of the menu (open/close)
    func setMenuState(visible: Bool) {
        drawerAnimator.setMenuState(visible: visible)
    }

    // Handle changes in orientation (screen rotation)
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        drawerAnimator.handleOrientationChange(with: coordinator)
    }
}

extension DrawerController: DrawerMenuViewControllerDelegate {
    // Handle selection of an item from the side menu
    func didSelectCell(at row: Int) {
        switch row {
        case 0:
            print("ROW 0 SELECTED")
        default:
            break
        }
        DispatchQueue.main.async { self.setMenuState(visible: false) }
    }
}
