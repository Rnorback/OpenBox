import UIKit

class FableLevelVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let fableLevelVM:FableVM = FableVM()
    let first:String = "A farmer had only one horse. One day, his horse ran away."
    let second:String = "His neighbors said, “I’m so sorry. This is such bad news. You must be so upset.”"
    let refrain:String = "The man just said, “We’ll see.”"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
