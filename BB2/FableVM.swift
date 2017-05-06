import Foundation

class FableVM: LevelVM {
    var lightData: [LightVM] = []
    var puzzles: [Puzzle] = [
        ReadFirstStanza()
    ]
    
    init() {
        prepLightData()
    }
    
    func prepLightData() {
        for puzzle in puzzles {
            let lightVM = LightVM(
                color: Colors.Fable.light,
                center: GridPosition(x: 0, y: 0).center,
                puzzleId: puzzle.puzzleId
            )
            
            lightData.append(lightVM)
        }
    }
}
