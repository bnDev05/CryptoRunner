
import UIKit

class NFTRoomViewController: UIViewController {
    @IBOutlet weak var nftImageView: UIImageView!
    @IBOutlet weak var nftNameLabel: UILabel!
    @IBOutlet weak var nftDescriptionLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    
    var index = 0
    let wonNFT = UserDefaults.standard.value(forKey: UserInformationManager.shared.wonNFT) as! [Int]
    let nftNames = ["HODLer", "Moon Trip", "Whale Hunter", "Pump It", "Diamond Hands", "Rug Pull Survivor", "Hash Cracker", "Block Verifier", "Smart Contract", "Consensus Master", "51% Attack", "Genesis Block"]
    let nftDesctiptions = ["Run 1000 meters in a single run", "Collect 50 keys in one run", "Collect 1000 keys in total", "Perform 5 speed boosts in a row", "Complete 5 runs in a row without losing", "Escape an unexpected obstacle at the last moment", "Solve your first puzzle", "Complete 10 puzzles", "Solve a puzzle without making any mistakes", "Complete 5 puzzles in a row", "Beat the hardest puzzle", "Unlock all NFTs in the game"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNFTs()
    }
    
    @IBAction func backToHomeGotClicked(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func leftPageTapped(_ sender: UIButton) {
        if index > 0 {
            index -= 1
            setupNFTs()
        }
    }
    
    @IBAction func rightPageLabel(_ sender: UIButton) {
        if index < 11 {
            index += 1
            setupNFTs()
        }
    }
}
extension NFTRoomViewController {
    private func setupNFTs() {
        if index >= 0 && index <= 11 {
            pageLabel.text = "\(index + 1)/12"
            nftDescriptionLabel.text = nftDesctiptions[index]
            if wonNFT.contains(index) {
                nftImageView.image = UIImage(named: "nft\(index)")
                nftNameLabel.text = nftNames[index]
            } else {
                nftImageView.image = UIImage(named: "nft\(index)u")
                nftNameLabel.text = "???"
            }
        }
    }
}
