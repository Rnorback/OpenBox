import Foundation

class WaitVM: LevelVM {
    
    var lightData:[LightVM] = []
    var puzzles:[Puzzle] = [
        WaitOneDay(),
        WaitOneHour(),
        WaitOneMinute(),
        WaitOneSecond()
    ]
    
    init() {
        prepLightData()
    }
    
    func prepLightData() {
        for puzzle in puzzles {
            let lightVM = LightVM(
                color: Colors.Wait.light,
                center: GridPosition(x: 0, y: 0).center,
                puzzleId: puzzle.puzzleId
            )
            
            lightData.append(lightVM)
        }
    }
}
