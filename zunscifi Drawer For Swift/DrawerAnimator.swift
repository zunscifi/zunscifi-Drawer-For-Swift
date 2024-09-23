import UIKit

class DrawerAnimator {
    
    // References to the DrawerController and menu properties
    private weak var controller: DrawerController?
    private var menuWidth: CGFloat
    private var menuOnTop: Bool
    private var rotationPadding: CGFloat
    private var menuTrailingConstraint: NSLayoutConstraint?
    
    init(controller: DrawerController, menuWidth: CGFloat, menuOnTop: Bool, rotationPadding: CGFloat) {
        self.controller = controller
        self.menuWidth = menuWidth
        self.menuOnTop = menuOnTop
        self.rotationPadding = rotationPadding
        
        // Set up the initial constraint based on whether the menu is on top or not
        setupMenuConstraint()
    }
    
    // Set up the initial constraint for the menu
    private func setupMenuConstraint() {
        guard let controller = controller, let menuViewController = controller.menuViewController else { return }
        
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if menuOnTop {
            // When the menu is on top, we set the leading constraint to hide it offscreen initially
            menuTrailingConstraint = menuViewController.view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: -menuWidth - rotationPadding)
            menuTrailingConstraint?.isActive = true
        }
        
        NSLayoutConstraint.activate([
            menuViewController.view.widthAnchor.constraint(equalToConstant: menuWidth),
            menuViewController.view.topAnchor.constraint(equalTo: controller.view.topAnchor),
            menuViewController.view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor)
        ])
    }
    
    // Animate the menu to open or close, depending on its visibility state
    func setMenuState(visible: Bool) {
        if visible {
            // Show the menu
            animateMenu(toPosition: menuOnTop ? 0 : menuWidth) { [weak self] _ in
                self?.controller?.menuIsVisible = true
            }
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.controller?.menuShadowView.alpha = 0.6
            }
        } else {
            // Hide the menu
            animateMenu(toPosition: menuOnTop ? (-menuWidth - rotationPadding) : 0) { [weak self] _ in
                self?.controller?.menuIsVisible = false
            }
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.controller?.menuShadowView.alpha = 0.0
            }
        }
    }
    
    // Perform the animation to move the menu to a specific position
    func animateMenu(toPosition position: CGFloat, completion: @escaping (Bool) -> Void) {
        guard let controller = controller else { return }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.menuOnTop {
                self.menuTrailingConstraint?.constant = position
                controller.view.layoutIfNeeded()
            } else {
                // If the menu is under the content, adjust the position of the main content view
                controller.view.subviews[1].frame.origin.x = position
            }
        }, completion: completion)
    }
    
    // Handle screen orientation changes and adjust the menu position accordingly
    func handleOrientationChange(with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in
            if self.menuOnTop {
                // Adjust the constraint for the menu if the orientation changes
                self.menuTrailingConstraint?.constant = self.controller?.menuIsVisible == true ? 0 : (-self.menuWidth - self.rotationPadding)
            }
        }
    }
    
    // Display the content controller (main content view) and remove any previous content
    func displayContentController<T: UIViewController>(viewController: T.Type, storyboardId: String) {
        guard let controller = controller else { return }
        
        // Remove previous content if it exists
        for subview in controller.view.subviews {
            if subview.tag == 99 {
                subview.removeFromSuperview()
            }
        }
        
        // Load the new view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        vc.view.tag = 99
        controller.view.insertSubview(vc.view, at: menuOnTop ? 0 : 1)
        controller.addChild(vc)
        
        // Position the new view if the menu is not on top of the content
        if !menuOnTop {
            if controller.menuIsVisible {
                vc.view.frame.origin.x = menuWidth
            }
            if let shadowView = controller.menuShadowView {
                vc.view.addSubview(shadowView)
            }
        }
        
        vc.didMove(toParent: controller)
    }
}
