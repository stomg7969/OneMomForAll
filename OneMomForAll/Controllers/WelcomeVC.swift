//
//  ViewController.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/25/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var welcomeLabel: CLTypingLabel!
    @IBOutlet weak var regiBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        // If you override this method, you 'MUST' call 'super' at some point.
//        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = true
//    } // view life cycle methods: Lecture 199.
//    // viewWillDisappear when leaving current view controller.
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.isNavigationBarHidden = false
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = K.appName
        
        regiBtn.applyDesign()
        loginBtn.applyDesign()
    }
}

extension UIButton {
    func applyDesign() {
        self.layer.cornerRadius = 25.0
        //        self.layer.cornerRadius = buttons.frame.size.height / 5.0
        //        self.layer.borderWidth = 2.0
        //        self.layer.borderColor = UIColor.white.cgColor
        //        self.clipsToBounds = true
    }
}
