import UIKit
import PromiseKit

class LightGroup {
    
    private(set) var lights:[LightButton] = []
    
    init(lightButtons:[LightButton]) {
        self.lights = lightButtons
        addTargets()
    }
}

//MARK: - Targets
extension LightGroup {
    
    func addTargets() {
        for light in lights {
            light.addTarget(
                self,
                action: #selector(lightActivated(button:)),
                for: .touchUpInside
            )
            light.addTarget(
                self,
                action: #selector(lightPressed),
                for: [.touchDown, .touchDragInside]
            )
            light.addTarget(
                self,
                action: #selector(lightReleased),
                for: [.touchDragOutside]
            )
        }
    }
    
    @objc fileprivate func lightPressed() {
        for light in lights {
            light.shrink()
        }
    }
    
    @objc fileprivate func lightReleased() {
        for light in lights {
            light.toNormalSize()
        }
    }
    
    @objc fileprivate func lightActivated(button:LightButton) {
        var promises:[Promise<Void>] = []
        for light in lights {
            promises.append(light.toNormalSizePromise())
        }
        
        when(fulfilled: promises).then {
            button.onClick()
        }.catch { (error) in
            guard let error = error as? AnimationError else {
                print("LightGroup Error: Passed an unexpected error type")
                return
            }
            
            print("LightGroup Error: \(error.localizedDescription)")
        }
    }
}
