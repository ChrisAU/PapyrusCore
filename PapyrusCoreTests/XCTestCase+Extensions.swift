//
//  XCTestCase+Extensions.swift
//  PapyrusCore
//
//  Created by Chris Nevin on 30/07/2016.
//  Copyright © 2016 CJNevin. All rights reserved.
//

import XCTest
@testable import PapyrusCore

extension XCTestCase {
    private static let letterMultipliers = [[1,1,1,2,1,1,1,1,1,1,1,2,1,1,1],
                             [1,1,1,1,1,3,1,1,1,3,1,1,1,1,1],
                             [1,1,1,1,1,1,2,1,2,1,1,1,1,1,1],
                             [2,1,1,1,1,1,1,2,1,1,1,1,1,1,2],
                             [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                             [1,3,1,1,1,3,1,1,1,3,1,1,1,3,1],
                             [1,1,2,1,1,1,2,1,2,1,1,1,2,1,1],
                             [1,1,1,2,1,1,1,1,1,1,1,2,1,1,1],
                             [1,1,2,1,1,1,2,1,2,1,1,1,2,1,1],
                             [1,3,1,1,1,3,1,1,1,3,1,1,1,3,1],
                             [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                             [2,1,1,1,1,1,1,2,1,1,1,1,1,1,2],
                             [1,1,1,1,1,1,2,1,2,1,1,1,1,1,1],
                             [1,1,1,1,1,3,1,1,1,3,1,1,1,1,1],
                             [1,1,1,2,1,1,1,1,1,1,1,2,1,1,1]]
    private static let wordMultipliers = [[3,1,1,1,1,1,1,3,1,1,1,1,1,1,3],
                           [1,2,1,1,1,1,1,1,1,1,1,1,1,2,1],
                           [1,1,2,1,1,1,1,1,1,1,1,1,2,1,1],
                           [1,1,1,2,1,1,1,1,1,1,1,2,1,1,1],
                           [1,1,1,1,2,1,1,1,1,1,2,1,1,1,1],
                           [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                           [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                           [3,1,1,1,1,1,1,2,1,1,1,1,1,1,3],
                           [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                           [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                           [1,1,1,1,2,1,1,1,1,1,2,1,1,1,1],
                           [1,1,1,2,1,1,1,1,1,1,1,2,1,1,1],
                           [1,1,2,1,1,1,1,1,1,1,1,1,2,1,1],
                           [1,2,1,1,1,1,1,1,1,1,1,1,1,2,1],
                           [3,1,1,1,1,1,1,3,1,1,1,1,1,1,3]]
    
    static func getBoard() -> Board {
        return Board(letterMultipliers: letterMultipliers, wordMultipliers: wordMultipliers)
    }
}
