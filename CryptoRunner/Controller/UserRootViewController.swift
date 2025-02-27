//
//  UserRootViewController.swift
//  CryptoRunner
//
//  Created by Behruz Norov on 27/02/25.
//

import UIKit

class UserRootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func hackGotClicked(_ sender: UIButton) {
        if let pushToMiniGame = storyboard?.instantiateViewController(identifier: "HackModeViewController") as? HackModeViewController {
            navigationController?.pushViewController(pushToMiniGame, animated: true)
        }
    }
    
    @IBAction func runGotClicked(_ sender: UIButton) {
        if let pushToRun = storyboard?.instantiateViewController(withIdentifier: "RunningMajorGameViewController") as? RunningMajorGameViewController {
            navigationController?.pushViewController(pushToRun, animated: true)
        }
    }
    
    @IBAction func nftRoomGotTapped(_ sender: UIButton) {
        if let pushToNFT = storyboard?.instantiateViewController(withIdentifier: "NFTRoomViewController") as? NFTRoomViewController {
            navigationController?.pushViewController(pushToNFT, animated: true)
        }
    }
}
