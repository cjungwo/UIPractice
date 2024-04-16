//
//  UIPracticeApp.swift
//  UIPractice
//
//  Created by JungWoo Choi on 11/4/2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct UIPracticeApp: App {
  var body: some Scene {
    WindowGroup {
      RouterView { _ in
        ContentView()
      }
    }
  }
}

extension UINavigationController: UIGestureRecognizerDelegate {
  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
