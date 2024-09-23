Here's a full `README.md` template for the codebase provided. This guide will help users understand how to set up and use the custom `DrawerController` with the `DrawerAnimator` class for a side drawer navigation system in their iOS app.

---

# DrawerController - Side Menu Controller for iOS

A customizable side drawer navigation controller built using `UIKit`. This implementation provides a fully functioning drawer menu with drag gestures, shadow effects, and a smooth toggle animation.

## Features

- **Side Menu Drawer**: Slide-in side menu with customizable width.
- **Shadow View**: A shadow overlay when the menu is visible.
- **Gesture Support**: Drag and tap gestures to open and close the menu.
- **Animated Transitions**: Smooth animations for toggling the drawer.

## Requirements

- iOS 13.0+
- Xcode 12.0+
- Swift 5.0+

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/zunscifi/zunscifi-Drawer-For-Swift.git
   ```

2. **Open the project in Xcode:**

   Navigate to the project folder and open the `.xcodeproj` or `.xcworkspace` file

## Usage

### Step 1: Set up the DrawerController

To implement the side drawer navigation, your main view controller should inherit from `DrawerController`. You will need to configure your storyboard to have the necessary view controllers (main content view and the drawer menu).

### Example Setup in Storyboard:

- **MainViewController**: This will be the main content of the app.
- **DrawerMenuViewController**: This will contain the menu items.

### Step 2: Using DrawerController in Code

#### Initialize and Set the DrawerController

To use the `DrawerController`, configure the controller in your `AppDelegate` or the initial view controller:

```swift
class MainViewController: DrawerController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Custom setup code
        self.setupMenu()
    }
    
    private func setupMenu() {
        self.menuWidth = 260 // Customize menu width
        self.menuOnTop = true // Set if the menu should be on top of the content
    }
}
```

### Step 3: Implementing the Menu

The `DrawerMenuViewController` handles the menu content. It can be implemented as a standard `UITableViewController` or `UIViewController`. Ensure you conform to `DrawerMenuViewControllerDelegate` to handle menu item selections.

Example:

```swift
class DrawerMenuViewController: UIViewController {
    var delegate: DrawerMenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up menu items and actions
    }

    func didSelectMenuItem(at row: Int) {
        delegate?.didSelectCell(at: row)
    }
}
```

### Step 4: Displaying the Content

You can display your content by calling the `displayContentController` method, which swaps the content when a menu item is selected.

```swift
override func didSelectCell(at row: Int) {
    switch row {
    case 0:
        displayContentController(viewController: HomeViewController.self, storyboardId: "HomeVC")
    case 1:
        displayContentController(viewController: SettingsViewController.self, storyboardId: "SettingsVC")
    default:
        break
    }
}
```

### Step 5: Animations and Gesture Handling

To enable the smooth animation of the drawer, you can use the provided `DrawerAnimator` class. It ensures the drawer opens and closes smoothly with customizable timing.

Example:

```swift
class DrawerAnimator {
    static func animateMenu(toPosition position: CGFloat, view: UIView, completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            view.frame.origin.x = position
        }, completion: completion)
    }
}
```

You can invoke the `animateMenu` method when you want to open or close the drawer.

### Step 6: Gesture Handling

The `DrawerController` includes gesture recognizers for dragging and tapping to open/close the menu. These are already set up in the `DrawerController` class, so no extra setup is required. 

You can enable dragging with:

```swift
let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
view.addGestureRecognizer(panGesture)
```

The tap gesture closes the menu when tapping outside:

```swift
let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
view.addGestureRecognizer(tapGesture)
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

By following these steps, you can easily set up and customize the side drawer menu in your iOS app using `DrawerController`.
