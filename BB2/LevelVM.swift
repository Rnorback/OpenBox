import Foundation

protocol LevelVM {
    var lightData:[LightVM] {get}
    var puzzles:[Puzzle] {get}
    
    func prepLightData()
}
