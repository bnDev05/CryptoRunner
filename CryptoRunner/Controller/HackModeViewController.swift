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
    @IBOutlet weak var targetBall: UIImageView!
    @IBOutlet weak var playerBall: UIImageView!
    
    var averageWidth: CGFloat = (UIScreen.main.bounds.width - 90.0) / 5
    var sizeToSetBalls: CGFloat = (UIScreen.main.bounds.width - 78.0) / 5
    let componentsPositionArray = GamePatternValidation.fetchGamePatters().shuffled()
    var index = 0
    var verticalViews: [UIView] = []
    var horizontalViews: [UIView] = []
    let redColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBariers()
        setupNecessaryComponents()
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
private extension HackModeViewController {
    private func setupNecessaryComponents() {
        let baseXValue = gameView.frame.minX
        let baseYValue = gameView.frame.minY
        if index >= componentsPositionArray.count {
            index = 0
        }
        gameView.layoutIfNeeded() // ✅ Ensure gameView is updated before positioning

        let data = componentsPositionArray[index]
        playerBall.center = CGPoint(x: baseXValue + data.ballPosition.width * sizeToSetBalls,
                                    y: baseYValue + data.ballPosition.height * sizeToSetBalls)
        targetBall.center = CGPoint(x: (baseXValue + (data.targetPosition.width * sizeToSetBalls)),
                                    y: (baseYValue + (data.targetPosition.height * sizeToSetBalls)))
    }
    
    func setupBariers() {
        if index >= componentsPositionArray.count {
            index = 0
        }
        
        gameView.layoutIfNeeded() // ✅ Ensure gameView is updated before positioning

        let data = componentsPositionArray[index]
        for i in 0..<data.horizontalPositions.count {
            let horizontalView = UIView()
            gameView.addSubview(horizontalView)
            horizontalViews.append(horizontalView)
            horizontalView.backgroundColor = redColor
            let viewSize = data.horizontalPositions[i]
            horizontalView.frame = CGRect(x: gameView.frame.minX + viewSize.width * sizeToSetBalls,
                                   y: gameView.frame.minY + viewSize.height * sizeToSetBalls,
                                   width: averageWidth, height: 3)
        }
        
        for i in 0..<data.verticalPositions.count {
            let verticalView = UIView()
            gameView.addSubview(verticalView)
            verticalViews.append(verticalView)
            verticalView.backgroundColor = redColor
            let viewSize = data.verticalPositions[i]
            verticalView.frame = CGRect(x: gameView.frame.minX + viewSize.width * sizeToSetBalls,
                                   y: gameView.frame.minY + viewSize.height * sizeToSetBalls,
                                   width: 3, height: averageWidth)
        }
    }
}
