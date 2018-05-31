//
//  ViewController.swift
//  Toast
//
//  Created by Raja on 31/05/18.
//  Copyright © 2018 Raja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfToast: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func toastBtnHandler(_ sender: Any) {
        ToastUtil.makeToast(tfToast.text!)
    }
    
}

