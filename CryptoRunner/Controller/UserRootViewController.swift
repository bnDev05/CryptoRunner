//
//  UserRootViewController.swift
//  CryptoRunner
//
//  Created by Behruz Norov on 27/02/25.
//

import UIKit

class UserRootViewController: UIViewController {

    var nftArray = UserDefaults.standard.value(forKey: UserInformationManager.shared.wonNFT) as! [Int]
    var allKeys = UserDefaults.standard.value(forKey: UserInformationManager.shared.keyConstant) as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if allKeys  >= 1000 {
            if !nftArray.contains(2) {
                nftArray.append(2)
                updateNFT(array: nftArray)
            }
        }
        if nftArray.count >= 11 {
            if !nftArray.contains(11) {
                nftArray.append(11)
                updateNFT(array: nftArray)
            }
        }
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
    
    func updateNFT(array: [Int]) {
        UserDefaults.standard.setValue(array, forKey: UserInformationManager.shared.wonNFT)
    }
}
