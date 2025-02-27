//
//  ViewController.swift
//  CryptoRunner
//
//  Created by Behruz Norov on 26/02/25.
//

import UIKit

class InitialEnteringViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loadingGotPressed(_ sender: UIButton) {
        if let passToMain = storyboard?.instantiateViewController(withIdentifier: "BlokchainRootNavController") {
            passToMain.modalPresentationStyle = .fullScreen
            present(passToMain, animated: true)
        }
    }
}

