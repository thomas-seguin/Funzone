//
//  WebViewController.swift
//  Project1
//
//  Created by admin on 6/5/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        
        guard let url = URL(string: "https://google.ca") else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

}
