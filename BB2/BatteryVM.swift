import Foundation

class BatteryVM: LevelVM {
    var lightData: [LightVM] = []
    var puzzles: [Puzzle] = [
        WhiteBattery(),
        GreenBattery(),
        YellowBattery(),
        RedBattery()
    ]
    
    init() {
        prepLightData()
    }
    
    func prepLightData() {
        for puzzle in puzzles {
            let lightVM = LightVM(
                color: Colors.Battery.light,
                center: GridPosition(x: 0, y: 0).center,
                puzzleId: puzzle.puzzleId
            )
            lightData.append(lightVM)
        }
    }
    
    

}
