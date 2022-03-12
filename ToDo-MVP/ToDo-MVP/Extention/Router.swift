//
//  Router.swift
//  ToDo-MVP
//
//  Created by 木元健太郎 on 2022/03/07.
//

import UIKit

final class Router {
  static let shared = Router()
  private init() {}

  private var window: UIWindow?

  func showRoot(window: UIWindow) {
    guard let vc = UIStoryboard.init(name: "ToDo", bundle: nil).instantiateInitialViewController() as? ToDoViewController else {
      return
    }
    //presenterとvc同士を繋ぎ合う
    let presenter = ToDoPresenter(output: vc)
    vc.inject(presenter: presenter)

    let nav = UINavigationController(rootViewController: vc)
    window.rootViewController = nav
    window.makeKeyAndVisible()
    self.window = window
  }
    
  private func show(from: UIViewController, to: UIViewController, completion:(() -> Void)? = nil){
    if let nav = from.navigationController {
      nav.pushViewController(to, animated: true)
      completion?()
    } else {
      from.present(to, animated: true, completion: completion)
    }
  }
}

