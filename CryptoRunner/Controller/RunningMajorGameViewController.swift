import UIKit
import SnapKit

class RunningMajorGameViewController: UIViewController {
    @IBOutlet weak var keysAmountLabel: UILabel!
    @IBOutlet var heartImageViews: [UIImageView]!
    @IBOutlet var pathViews: [UIView]!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nodeImageView: UIImageView!
    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backImage: UIImageView!
    
    var keysAmount = 0
    var lives = 3
    var distance = 0
    var gameTimer: Timer?
    var speed: CGFloat = 5.0
    var speedBoostActive = false
    let redBarrierColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1.0)
    let pinkSpeedColor = UIColor(red: 255/255, green: 0, blue: 238/238, alpha: 1.0)
    var speedBoost = 0
    
    let nftKey = UserInformationManager.shared.wonNFT
    var nftArray = UserDefaults.standard.value(forKey: UserInformationManager.shared.wonNFT) as! [Int]
    var allKeys = UserDefaults.standard.value(forKey: UserInformationManager.shared.keyConstant) as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateHeartsDisplay()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startGameLoop()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gameTimer?.invalidate()
    }
    
    func startGameLoop() {
        gameTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
    }
    
    @objc func updateGame() {
        spawnRandomObjects()
        moveObjectsDown()
        updateDistance()
    }
    
    func spawnRandomObjects() {
        let randomPathIndex = Int.random(in: 0..<pathViews.count)
        let pathView = pathViews[randomPathIndex]
        let pathFrame = pathView.convert(pathView.bounds, to: self.view)

        for subview in self.view.subviews {
            let existingFrame = subview.convert(subview.bounds, to: self.view)
            if abs(existingFrame.minY - (-30)) < 40 && existingFrame.minX == pathFrame.minX {
                return
            }
        }

        let newObject = UIView()
        newObject.frame = CGRect(x: pathFrame.minX, y: -30, width: pathFrame.width, height: 30)
        self.view.addSubview(newObject)

        let randomObject = Int.random(in: 0...10)

        if randomObject == 0 { // Red barrier
            if speedBoost > 0 {
                speedBoost -= 1
            }
            newObject.backgroundColor = redBarrierColor
            newObject.frame.size.height = 6
            newObject.tag = 1
        } else if randomObject < 2 { // Key
            if speedBoost > 0 {
                speedBoost -= 1
            }
            let imageName = ["blackHackModeKey", "whiteKeyImage"].randomElement()!
            let keyImageView = UIImageView(image: UIImage(named: imageName))
            keyImageView.contentMode = .scaleAspectFit
            keyImageView.frame = newObject.bounds
            newObject.addSubview(keyImageView)
            newObject.tag = 2
        } else if randomObject < 3 { // Pink speed area
            speedBoost += 1
            if speedBoost >= 5 {
                if !nftArray.contains(3) {
                    nftArray.append(3)
                    updateNFT(array: nftArray)
                }
            }
            newObject.backgroundColor = pinkSpeedColor.withAlphaComponent(0.24)
            let topView = UIView()
            let bottomView = UIView()
            topView.backgroundColor = pinkSpeedColor
            bottomView.backgroundColor = pinkSpeedColor
            newObject.addSubview(topView)
            topView.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(2)
            }
            newObject.addSubview(bottomView)
            bottomView.snp.makeConstraints { make in
                make.bottom.left.right.equalToSuperview()
                make.height.equalTo(2)
            }
            newObject.frame.size.height = 130
            newObject.tag = 3
        } else {
            newObject.removeFromSuperview()
            return
        }

        view.bringSubviewToFront(nodeImageView)
        view.bringSubviewToFront(topView)
        view.bringSubviewToFront(bottomStack)
        view.bringSubviewToFront(headerView)
    }

    func moveObjectsDown() {
        for subview in self.view.subviews {
            if subview.tag == 1 || subview.tag == 2 || subview.tag == 3 {
                subview.frame.origin.y += speed

                let objectFrameInMainView = subview.convert(subview.bounds, to: self.view)
                let playerFrameInMainView = nodeImageView.convert(nodeImageView.bounds, to: self.view)

                if objectFrameInMainView.intersects(playerFrameInMainView) {
                    print("💥 Collision detected with object at \(objectFrameInMainView) and player at \(playerFrameInMainView)")
                    handleCollision(with: subview)
                }

                if subview.frame.origin.y > self.view.frame.height {
                    subview.removeFromSuperview()
                }
            }
        }
    }

    func handleCollision(with object: UIView) {
        print("Collision detected with object \(object.tag) at frame: \(object.frame)")

        if object.tag == 1 { // Red barrier
            print("❌ HIT RED BARRIER! Player frame: \(nodeImageView.frame)")
            backImage.image = nil
            object.removeFromSuperview()
            loseLife()
        } else if object.tag == 2 {
            collectKey()
            object.removeFromSuperview()
        } else if object.tag == 3 {
            backImage.image = UIImage(named: "speedShownBackImage")
            activateSpeedBoost()
        } else {
            backImage.image = nil
        }
    }
    
    func loseLife() {
        if lives > 0 {
            lives -= 1
            updateHeartsDisplay()
        }
        
        if lives == 0 {
            gameOver()
        }
    }
    
    func updateHeartsDisplay() {
        for (index, heart) in heartImageViews.enumerated() {
            if heart.tag < lives {
                heart.image = UIImage(named: "filledHeart")
            } else {
                heart.image = UIImage(named: "emptyHeart")
            }
        }
    }
    
    func collectKey() {
        keysAmount += 1
        if keysAmount == 50 {
            if !nftArray.contains(1) {
                nftArray.append(1)
                updateNFT(array: nftArray)
            }
        }
        if allKeys + keysAmount == 1000 {
            if !nftArray.contains(2) {
                nftArray.append(2)
                updateNFT(array: nftArray)
            }
        }
        keysAmountLabel.text = "\(keysAmount)"
    }
    
    func activateSpeedBoost() {
        if !speedBoostActive {
            speedBoostActive = true
            speed *= 1.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if self.speedBoostActive { // Ensure reset happens only once
                    self.backImage.image = nil
                    self.speed /= 1.5
                    self.speedBoostActive = false
                }
            }
        }
    }
    
    func updateDistance() {
        distance += 1
        if distance == 1000 {
            if !nftArray.contains(0) {
                nftArray.append(0)
                updateNFT(array: nftArray)
            }
        }
        if distance == 1200 {
            if !nftArray.contains(4) {
                nftArray.append(4)
                updateNFT(array: nftArray)
            }
        }
        if distance == 800 {
            if !nftArray.contains(5) {
                nftArray.append(5)
                updateNFT(array: nftArray)
            }
        }
        distanceLabel.text = "\(distance)m"
    }
    
    func updateNFT(array: [Int]) {
        UserDefaults.standard.setValue(array, forKey: nftKey)
    }
    
    func gameOver() {
        gameTimer?.invalidate()
        if let currentKeys = UserDefaults.standard.value(forKey: UserInformationManager.shared.keyConstant) as? Int {
            UserDefaults.standard.setValue(currentKeys + keysAmount, forKey: UserInformationManager.shared.keyConstant)
        }
        if let pushToPause = storyboard?.instantiateViewController(withIdentifier: "CustomAlertViewController") as? CustomAlertViewController {
            pushToPause.titleText = "Game Over"
            pushToPause.subtitleText = ""
            pushToPause.centerImageName = "loseImage"
            pushToPause.firstButtonTitle = "New Run"
            pushToPause.secondButtonTitle = "Back to Home"
            pushToPause.isGameOver = true
            navigationController?.pushViewController(pushToPause, animated: true)
        }
    }
    
    @IBAction func leftButtonGotTapped(_ sender: UIButton) {
        moveNodeLeft()
    }
    
    @IBAction func rightButtonGotTapped(_ sender: UIButton) {
        moveNodeRight()
    }
    
    func moveNodeLeft() {
        if let currentIndex = pathViews.firstIndex(where: { $0 == nodeImageView.superview }), currentIndex > 0 {
            let newParentView = pathViews[currentIndex - 1]
            moveNode(to: newParentView)
        }
    }

    func moveNodeRight() {
        if let currentIndex = pathViews.firstIndex(where: { $0 == nodeImageView.superview }), currentIndex < pathViews.count - 1 {
            let newParentView = pathViews[currentIndex + 1]
            moveNode(to: newParentView)
        }
    }

    private func moveNode(to newParentView: UIView) {
        newParentView.addSubview(nodeImageView)
        nodeImageView.snp.remakeConstraints { make in
            make.left.equalTo(newParentView).offset(8)
            make.right.equalTo(newParentView).offset(-8)
            make.bottom.equalToSuperview().offset(-98)
            make.height.equalTo(nodeImageView.snp.width).multipliedBy(70.0/52.0)
        }
        
        UIView.animate(withDuration: 0.1) {
            newParentView.layoutIfNeeded()
        }
    }
    
    @IBAction func pauseGotPressed(_ sender: UIButton) {
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
