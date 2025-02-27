//
//  HackModeViewController.swift
//  CryptoRunner
//
//  Created by Behruz Norov on 27/02/25.
//

import UIKit

class HackModeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func returnToHome(_ sender: UIButton) {
        if let pushToPause = storyboard?.instantiateViewController(withIdentifier: "CustomAlertViewController") as? CustomAlertViewController {
            pushToPause.titleText = "Pause"
            pushToPause.subtitleText = ""
            pushToPause.centerImageName = "mainScreenCenterImage"
            pushToPause.firstButtonTitle = "Continue"
            pushToPause.secondButtonTitle = "Back to Home"
            pushToPause.isGameOver = nil
            navigationController?.pushViewController(pushToPause, animated: true)
        }
    }
}
