import UIKit

class BatteryVC: UIViewController {
    
    var batteryVM:BatteryVM = BatteryVM()
    let horizontalLightBatterySpacing:CGFloat = 100
    var verticalLightSpacing:CGFloat {
        return view.frame.height/CGFloat(batteryVM.puzzles.count)
    }
    
    var label:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Menu.bg
        UIDevice.current.isBatteryMonitoringEnabled = true
        layoutLights()
        layoutBatteries()
        addObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        batteryVM.puzzles.forEach { (puzzle) in
            puzzle.checkForSuccess(value: nil)
        }
    }
    
    deinit {
        print("deinit")
        removeObservers()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(powerStateChanged), name: Notification.Name.NSProcessInfoPowerStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange), name: Notification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: Notification.Name.UIDeviceBatteryLevelDidChange, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.NSProcessInfoPowerStateDidChange, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIDeviceBatteryLevelDidChange, object: nil)
    }
    
    
    func layoutBatteries() {
        for (index, puzzle) in batteryVM.puzzles.enumerated() {
            let battery = BatteryView(puzzleId: puzzle.puzzleId)
            battery.center = CGPoint(
                x: view.frame.width/2 + horizontalLightBatterySpacing/2,
                y: verticalLightSpacing/2 + verticalLightSpacing * CGFloat(index)
            )
            view.addSubview(battery)
        }
    }

    func layoutLights() {
        for (index,lightVM) in batteryVM.lightData.enumerated() {
            
            let light = LightButton(lightVM: lightVM)
            light.center = CGPoint(
                x: view.frame.width/2 - horizontalLightBatterySpacing,
                y: verticalLightSpacing/2 + verticalLightSpacing * CGFloat(index)
            )
            view.addSubview(light)
            light.addTarget(self, action: #selector(lightPressed), for: .touchUpInside)
        }
    }
}

//MARK: - Notification Handling
extension BatteryVC {
    
    func lightPressed() {
        print("Light pressed")
    }
    
    func batteryStateDidChange(_ notification: NSNotification){
        // The stage did change: plugged, unplugged, full charge...
        let greenPuzzle = batteryVM.puzzles.filter{$0.puzzleId == .greenBattery}
            .first as? GreenBattery
        greenPuzzle?.checkForSuccess()
    }
    
    func batteryLevelDidChange(_ notification: NSNotification){
        // The battery's level did change (98%, 99%, ...)
        let redPuzzle = batteryVM.puzzles.filter{$0.puzzleId == .redBattery}
            .first as? RedBattery
        redPuzzle?.checkForSuccess()
    }
    
    func willResignActive(_ notification: NSNotification) {
        // Checks if the app was exited
        let whitePuzzle = batteryVM.puzzles.filter{$0.puzzleId == .whiteBattery}
            .first as? WhiteBattery
        whitePuzzle?.checkForSuccess()
    }
    
    func powerStateChanged(_ notification: NSNotification) {
        let yellowPuzzle = batteryVM.puzzles.filter{$0.puzzleId == .yellowBattery}
            .first as? YellowBattery
        yellowPuzzle?.checkForSuccess()
    }
}
