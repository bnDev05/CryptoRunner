//
//  CustomAlertViewController.swift
//  CryptoRunner
//
//  Created by Behruz Norov on 27/02/25.
//

import UIKit

class CustomAlertViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var titleText: String?
    var subtitleText: String?
    var centerImageName: String?
    var firstButtonTitle: String?
    var secondButtonTitle: String?
    var isGameOver: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserAppearance()
    }
    
    @IBAction func topButtonGotClicked(_ sender: UIButton) {
        if let isGameOver = isGameOver {
            if isGameOver {
                if let pushToRun = storyboard?.instantiateViewController(withIdentifier: "RunningMajorGameViewController") as? RunningMajorGameViewController {
                    navigationController?.pushViewController(pushToRun, animated: true)
                }
            } else {
                
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func bottomButtonGotClicked(_ sender: UIButton) {
        if let isGameOver = isGameOver {
            if isGameOver {
                navigationController?.popToRootViewController(animated: true)
            } else {
                
            }
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func setupUserAppearance() {
        if let titleText = titleText, 
            let subtitleText = subtitleText,
            let centerImageName = centerImageName,
            let firstButtonTitle = firstButtonTitle,
            let secondButtonTitle = secondButtonTitle {
            titleLabel.text = titleText
            subtitleLabel.text = subtitleText
            centerImageView.image = UIImage(named: centerImageName)
            topButton.setTitle(firstButtonTitle, for: .normal)
            bottomButton.setTitle(secondButtonTitle, for: .normal)
        } else {
            topButton.isHidden = true
        }
    }
}
