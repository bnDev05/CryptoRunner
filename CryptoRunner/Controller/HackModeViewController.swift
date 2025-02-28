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
    var componentsPositionArray = GamePatternValidation.fetchGamePatters().shuffled()
    var index = 0
    var verticalViews: [UIView] = []
    var horizontalViews: [UIView] = []
    let redColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1.0)
    let whiteColor = UIColor.white
    var lives = 3
    var keysAmount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateHeartsDisplay()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupGame()
    }
    
    @IBAction func leftTapped(_ sender: UIButton) { movePlayer(dx: -sizeToSetBalls, dy: 0) }
    @IBAction func rightTapped(_ sender: UIButton) { movePlayer(dx: sizeToSetBalls, dy: 0) }
    @IBAction func bottomTapped(_ sender: UIButton) { movePlayer(dx: 0, dy: sizeToSetBalls) }
    @IBAction func topTapped(_ sender: UIButton) { movePlayer(dx: 0, dy: -sizeToSetBalls) }
    
    private func movePlayer(dx: CGFloat, dy: CGFloat) {
        let newX = playerBall.center.x + dx
        let newY = playerBall.center.y + dy
        
        if gameView.bounds.contains(CGPoint(x: newX, y: newY)) {
            playerBall.center = CGPoint(x: newX, y: newY)
            checkCollisions()
        }
    }
    
    private func checkCollisions() {
        if playerBall.frame.intersects(targetBall.frame) {
            index += 1
            resetGame()
        }
        
        for barrier in horizontalViews + verticalViews {
            if barrier.backgroundColor == redColor && playerBall.frame.intersects(barrier.frame) {
                loseLife()
                return
            }
        }
    }
    
    private func setupGame() {
        setupBarriers()
        highlightRandomBarriers()
//        gameView.bringSubviewToFront(targetBall)
//        gameView.bringSubviewToFront(playerBall)
        positionBalls()
    }
    
    private func resetGame() {
        horizontalViews.forEach { $0.removeFromSuperview() }
        verticalViews.forEach { $0.removeFromSuperview() }
        horizontalViews.removeAll()
        verticalViews.removeAll()
        setupGame()
    }
    
    private func setupBarriers() {
        guard index < componentsPositionArray.count else { index = 0; return }
        
        let data = componentsPositionArray[index]
        gameView.layoutIfNeeded()
        
        for pos in data.horizontalPositions {
            let horizontalView = UIView(frame: CGRect(x: pos.width * sizeToSetBalls, y: pos.height * sizeToSetBalls, width: averageWidth, height: 3))
            horizontalView.backgroundColor = redColor
            gameView.addSubview(horizontalView)
            horizontalViews.append(horizontalView)
        }
        
        for pos in data.verticalPositions {
            let verticalView = UIView(frame: CGRect(x: pos.width * sizeToSetBalls, y: pos.height * sizeToSetBalls, width: 3, height: averageWidth))
            verticalView.backgroundColor = redColor
            gameView.addSubview(verticalView)
            verticalViews.append(verticalView)
        }
    }
    
    private func positionBalls() {
        let data = componentsPositionArray[index]
        let ballSize: CGFloat = 25 // Since both playerBall and targetBall are 25x25
        let baseX = gameView.frame.origin.x
        let baseY = gameView.frame.origin.y

        gameView.layoutIfNeeded()
        
        playerBall.frame = CGRect(
            x: baseX + (data.ballPosition.width * sizeToSetBalls) - (ballSize / 2),
            y: baseY + (data.ballPosition.height * sizeToSetBalls) - (ballSize / 2),
            width: ballSize,
            height: ballSize
        )

        targetBall.frame = CGRect(
            x: baseX + (data.targetPosition.width * sizeToSetBalls) - (ballSize / 2),
            y: baseY + (data.targetPosition.height * sizeToSetBalls) - (ballSize / 2),
            width: ballSize,
            height: ballSize
        )
    }

    private func highlightRandomBarriers() {
        horizontalViews.randomElement()?.backgroundColor = whiteColor
        verticalViews.randomElement()?.backgroundColor = whiteColor
    }
    
    private func loseLife() {
        if lives > 0 {
            lives -= 1
            updateHeartsDisplay()
        }
        
        if lives == 0 { gameOver() }
    }
    
    private func updateHeartsDisplay() {
        for (index, heart) in heartImages.enumerated() {
            heart.image = UIImage(named: index < lives ? "filledHeart" : "emptyHeart")
        }
    }
    
    private func gameOver() {
        if let currentKeys = UserDefaults.standard.value(forKey: UserInformationManager.shared.keyConstant) as? Int {
            UserDefaults.standard.setValue(currentKeys + keysAmount, forKey: UserInformationManager.shared.keyConstant)
        }
        
        if let pushToPause = storyboard?.instantiateViewController(withIdentifier: "CustomAlertViewController") as? CustomAlertViewController {
            pushToPause.titleText = "Game Over"
            pushToPause.centerImageName = "loseImage"
            pushToPause.firstButtonTitle = "New Run"
            pushToPause.secondButtonTitle = "Back to Home"
            pushToPause.isGameOver = true
            navigationController?.pushViewController(pushToPause, animated: true)
        }
    }
}
