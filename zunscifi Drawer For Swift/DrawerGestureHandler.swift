import UIKit

class DrawerGestureHandler: NSObject, UIGestureRecognizerDelegate {
    private weak var controller: DrawerController?
    private var canDrag: Bool = false
    private var dragStartingPoint: CGFloat = 0.0
    
    init(controller: DrawerController) {
        self.controller = controller
    }
    
    func addGestures(to view: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGesture.delegate = self
        panGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        tapGesture.numberOfTapsRequired = 1
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        // Handle pan gesture for dragging the menu
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended && controller?.menuIsVisible == true {
            controller?.setMenuState(visible: false)
        }
    }
}
