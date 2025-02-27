//
//  HackModeViewController.swift
//  CryptoRunner
//
//  Created by Behruz Norov on 27/02/25.
//

import UIKit

class HackModeViewController: UIViewController {
    @IBOutlet var heartImages: [UIImageView]!
    @IBOutlet weak var keysQuantity: UILabel!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var keyButton: UIButton!
    
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
    
    @IBAction func topTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func leftTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func rightTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func bottomTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func keyTapped(_ sender: UIButton) {
        
    }
}
