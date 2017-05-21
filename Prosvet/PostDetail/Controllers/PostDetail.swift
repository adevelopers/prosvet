//
//  PostDetail.swift
//  TableViewDetail
//
//  Created by adeveloper on 20.04.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit




class PostDetail: UIViewController {
    
    var post:Post?
    
    @IBOutlet weak var uiTitle: UILabel!
    @IBOutlet weak var uiText: UIWebView!
    @IBOutlet weak var uiBack: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        if post != nil {
            uiTitle.text = post?.title
            uiText.loadHTMLString((post?.text)!, baseURL: nil)
         
        }
        
    }
    
    func setupUI(){

        uiBack.setTitle("back".localized, for: .normal)
    }

    
    @IBAction func clickBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

 

}
