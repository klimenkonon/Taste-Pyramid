//
//  ViewController.swift
//  PharaohCoffee
//
//  Created by Danylo Klymenko on 20.08.2024.
//

import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImageView = UIImageView(image: UIImage(named: "background"))
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.frame = view.bounds
            backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(backgroundImageView, at: 0)
    }
    
    func openApp() {
        DispatchQueue.main.async {
            let view = RootView()
            let hostingController = UIHostingController(rootView: view)
            self.setRootViewController(hostingController)
        }
    }
    
    func openWeb(stringURL: String) {
        DispatchQueue.main.async {
            let webView = ADJWebHandler(url: stringURL)
            self.setRootViewController(webView)
        }
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = viewController
        }
    }
    
    func createURL(mainURL: String, deviceID: String, facebookURL: String, advertiseID: String) -> (String) {
        var url = ""
        
        url = "\(mainURL)?sdjv=\(deviceID)&cxbr=\(advertiseID)&wefcgv=\(facebookURL)"
        
        return url
    }
}
