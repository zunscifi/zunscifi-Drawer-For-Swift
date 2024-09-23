# DrawerMenu Project

## Overview

This project is a custom implementation of a side navigation drawer (commonly referred to as a "hamburger menu") using UIKit in Swift. It provides a flexible and customizable menu for navigating through different parts of an iOS app. The project consists of multiple components, including a custom `UITableViewCell` for menu items, a view controller for the side menu, gesture handlers for toggling the menu, and animations for smooth interactions.

## Table of Contents
- [Project Structure](#project-structure)
- [Features](#features)
- [Usage](#usage)
- [Customization](#customization)
- [Credits](#credits)

## Project Structure

1. **DrawerCell.swift**  
   A custom `UITableViewCell` named `DrawerCell` used in the menu for each individual item. It contains an icon and a label and is easily reusable across different sections.

2. **DrawerMenuViewController.swift**  
   A `UIViewController` that displays the side menu using a `UITableView`. It delegates the user’s selections back to the main view controller through the `DrawerMenuViewControllerDelegate` protocol.

3. **DrawerMenuModel.swift**  
   A data model representing each menu item, including its icon and title.

4. **DrawerController.swift**  
   The main controller that manages the menu's appearance and handles the interaction between the menu and the main content. It includes functionality to toggle the menu, manage animations, and respond to screen orientation changes.

5. **DrawerGestureHandler.swift**  
   Handles user gestures such as dragging and tapping to interact with the menu. It allows users to swipe the menu in and out or close the menu with a tap outside of the menu area.

6. **DrawerAnimator.swift**  
   Manages the animations for opening and closing the menu, including its position, visibility, and the shadow effect that appears behind the menu when it's open.

## Features

- **Customizable Side Menu**: The side menu can be customized with different icons and titles for each item.
- **Gesture Support**: Users can open and close the menu using swipe and tap gestures.
- **Smooth Animations**: The menu opens and closes with fluid animations, providing a polished user experience.
- **Orientation Support**: The menu layout adjusts dynamically based on screen orientation.
- **Delegate Pattern**: Menu selections are handled via a delegate, allowing for easy customization of what happens when a menu item is selected.

## Usage

### 1. Setup

To use this drawer menu in your project, follow these steps:

- **Step 1**: Add the provided `.swift` files to your project.
- **Step 2**: In your `Main.storyboard`, configure your view controllers:
   - Add a `UIViewController` for the main content.
   - Add another `UIViewController` for the drawer menu and assign it the class `DrawerMenuViewController`.
   - Use `UINavigationController` for any screen transitions.
   
- **Step 3**: Set up the side menu by using the `DrawerController` class as your main view controller. The `DrawerController` automatically manages the toggling and positioning of the menu.

### 2. Register Menu Items

In the `DrawerMenuViewController`, register the menu items by adding icons and titles in the `menuItems` array.

```swift
var menuItems: [DrawerMenuModel] = [
    DrawerMenuModel(icon: UIImage(systemName: "heart")!, title: "Item 1"),
    DrawerMenuModel(icon: UIImage(systemName: "heart")!, title: "Item 2"),
    // Add more items as needed
]
```

### 3. Toggle the Menu

You can toggle the menu using the `toggleMenu()` method in `DrawerController`. For example, to open the menu when a button is pressed:

```swift
MENU.target = self
MENU.action = #selector(toggleMenu)
```

### 4. Handle Menu Selection

Implement the `DrawerMenuViewControllerDelegate` in your `DrawerController` to handle menu item selection:

```swift
func didSelectCell(at row: Int) {
    switch row {
    case 0:
        // Handle item 1 selection
    case 1:
        // Handle item 2 selection
    default:
        break
    }
}
```

## Customization

- **Menu Width**: The width of the menu can be adjusted by changing the `menuWidth` property in the `DrawerController`.
  
```swift
public var menuWidth: CGFloat = 260
```

- **Animation Duration**: You can modify the animation duration and effects in `DrawerAnimator` by adjusting the values in the `animateMenu` method.

- **Menu Appearance**: Customize the appearance of the menu by modifying the `DrawerCell`'s appearance in `awakeFromNib()`. You can set different colors, fonts, or images for the icons and labels.

```swift
self.iconImageView.tintColor = .white
self.titleLabel.textColor = .white
```

## Credits

This project uses UIKit and Swift for iOS development. Feel free to use and modify the project to suit your needs. If you encounter any issues or would like to contribute, please feel free to submit a pull request.

---

Enjoy using the DrawerMenu!
