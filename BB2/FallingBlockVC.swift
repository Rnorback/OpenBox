import UIKit
import CoreMotion

class FallingBlockVC: UIViewController {
    
    var squareView: UIView!
    var anchorView: UIView!
    var attachment: UIAttachmentBehavior!
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    let motionManager:CMMotionManager = CMMotionManager()
    var snapSquares:[UIView] = []
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        squareView = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        squareView.backgroundColor = UIColor.blue
        squareView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4.0))
        view.addSubview(squareView)
        
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
//        anchorView = UIView(frame: CGRect(x: view.center.x, y: view.center.y, width: 20, height: 20))
//        anchorView.backgroundColor = UIColor.red
//        view.addSubview(anchorView)
//        
//        attachment = UIAttachmentBehavior(item: squareView, attachedToAnchor: CGPoint(x: anchorView.center.x, y: anchorView.center.y))
//        
//
//        animator.addBehavior(attachment)
        
        gravity = UIGravityBehavior(items: [squareView])
        setupAccelerometer()
        animator.addBehavior(gravity)
        
        let itemBehavior = UIDynamicItemBehavior(items: [squareView])
        itemBehavior.elasticity = 0.3
        //itemBehavior.friction = 0.0
        itemBehavior.angularResistance = 0.0
        animator.addBehavior(itemBehavior)
        
        gravity.action =  { [unowned self] in
            FallingBlockVC.count += 1
            if FallingBlockVC.count % 2 == 0 {
                let snapSquare = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
                snapSquare.center = self.squareView.center
                snapSquare.transform = self.squareView.transform
                snapSquare.layer.borderColor = UIColor.gray.cgColor
                snapSquare.backgroundColor = UIColor.clear
                snapSquare.layer.borderWidth = 1
                DispatchQueue.main.async {
                    self.view.addSubview(snapSquare)
                }
                self.snapSquares.append(snapSquare)
            }
            
            if self.snapSquares.count > 100 {
                DispatchQueue.main.async {
                    self.snapSquares.first?.removeFromSuperview()
                    self.snapSquares.removeFirst()
                }
            }
        }
    }
    
    static var count = 0
//Curious how to use unowned self in this instance
    //    func snapShot() {
//        FallingBlockVC.count += 1
//        if FallingBlockVC.count % 10 == 0 {
//            let snapSquare = UIView(frame: squareView.frame)
//            snapSquare.transform = squareView.transform
//            snapSquare.layer.borderColor = UIColor.gray.cgColor
//            snapSquare.backgroundColor = UIColor.clear
//            snapSquare.layer.borderWidth = 1
//            view.addSubview(snapSquare)
//        }
//    }
    
    deinit {
        print("Deinit Falling Block")
        motionManager.stopAccelerometerUpdates()
        FallingBlockVC.count = 0
    }
    
    func setupAccelerometer() {
        motionManager.accelerometerUpdateInterval = 0.4
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates(to: OperationQueue(), withHandler: {[unowned self] (data, error) in
                if error != nil {
                    print("\(type(of:self)), Accelerometer Error")
                    return
                }
                let magnitude:Double = 1.0
                let xAccel = CGFloat(magnitude * data!.acceleration.x)
                let yAccel = CGFloat(-magnitude * data!.acceleration.y)
                DispatchQueue.main.async {
                    self.gravity.gravityDirection = CGVector(dx: xAccel, dy: yAccel)
                }
            })
        }
    }
}
