//
//  PDFViewController.swift
//  Project1
//
//  Created by admin on 6/5/22.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController, PDFViewDelegate {
    
    let pdfView = PDFView()
    
    public var bookName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        view.addSubview(pdfView)
        
        pdfView.autoScales = true

        // Document
        guard let url = Bundle.main.url(forResource: bookName, withExtension: "pdf") else {
            return
        }
        
        guard let document = PDFDocument(url: url) else {
            return
        }
        
        pdfView.document = document
        pdfView.delegate = self
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pdfView.frame = view.bounds
    }
    
    
    

  

}
