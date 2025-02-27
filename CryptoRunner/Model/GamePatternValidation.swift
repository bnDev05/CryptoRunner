

import Foundation

struct GamePatternValidation {
    let ballPosition: CGSize
    let targetPosition: CGSize
    let horizontalPositions: [CGSize]
    let verticalPositions: [CGSize]
    
    static func fetchGamePatters() -> [GamePatternValidation] {
        [
            GamePatternValidation(ballPosition: CGSize(width: 1, height: 1), targetPosition: CGSize(width: 4, height: 4),
                                  horizontalPositions: [CGSize(width: 3, height: 2), CGSize(width: 4, height: 2), CGSize(width: 2, height: 3), CGSize(width: 3, height: 3), CGSize(width: 1, height: 4)],
                                  verticalPositions: [CGSize(width: 2, height: 0), CGSize(width: 1, height: 3), CGSize(width: 2, height: 4), CGSize(width: 4, height: 4)]),
            GamePatternValidation(ballPosition: CGSize(width: 2, height: 1), targetPosition: CGSize(width: 3, height: 4),
                                  horizontalPositions: [CGSize(width: 3, height: 1), CGSize(width: 2, height: 2), CGSize(width: 4, height: 3), CGSize(width: 3, height: 3), CGSize(width: 4, height: 2)],
                                  verticalPositions: [CGSize(width: 3, height: 2), CGSize(width: 1, height: 4), CGSize(width: 4, height: 3), CGSize(width: 4, height: 4)]),
            GamePatternValidation(ballPosition: CGSize(width: 4, height: 1), targetPosition: CGSize(width: 4, height: 4),
                                  horizontalPositions: [CGSize(width: 1, height: 1), CGSize(width: 2, height: 1), CGSize(width: 3, height: 3), CGSize(width: 4, height: 3), CGSize(width: 0, height: 3)],
                                  verticalPositions: [CGSize(width: 3, height: 2), CGSize(width: 1, height: 4), CGSize(width: 4, height: 3), CGSize(width: 4, height: 4)]),
            GamePatternValidation(ballPosition: CGSize(width: 4, height: 1), targetPosition: CGSize(width: 1, height: 4),
                                  horizontalPositions: [CGSize(width: 1, height: 1), CGSize(width: 2, height: 1), CGSize(width: 2, height: 2), CGSize(width: 1, height: 3), CGSize(width: 4, height: 3)],
                                  verticalPositions: [CGSize(width: 1, height: 1), CGSize(width: 2, height: 3), CGSize(width: 4, height: 3), CGSize(width: 1, height: 4)]),
            GamePatternValidation(ballPosition: CGSize(width: 4, height: 1), targetPosition: CGSize(width: 1, height: 4),
                                  horizontalPositions: [CGSize(width: 0, height: 1), CGSize(width: 1, height: 2), CGSize(width: 4, height: 2), CGSize(width: 3, height: 4), CGSize(width: 2, height: 2)],
                                  verticalPositions: [CGSize(width: 1, height: 1), CGSize(width: 2, height: 2), CGSize(width: 4, height: 3), CGSize(width: 4, height: 4)]),
            GamePatternValidation(ballPosition: CGSize(width: 3, height: 2), targetPosition: CGSize(width: 1, height: 4),
                                  horizontalPositions: [CGSize(width: 0, height: 1), CGSize(width: 3, height: 2), CGSize(width: 4, height: 2), CGSize(width: 2, height: 2), CGSize(width: 3, height: 4)],
                                  verticalPositions: [CGSize(width: 2, height: 2), CGSize(width: 3, height: 3), CGSize(width: 4, height: 4), CGSize(width: 4, height: 3)])
        ]
    }
}
