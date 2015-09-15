//
//  Square.swift
//  Papyrus
//
//  Created by Chris Nevin on 14/08/2015.
//  Copyright © 2015 CJNevin. All rights reserved.
//

import Foundation

public enum Modifier {
    case None, Letterx2, Letterx3, Center, Wordx2, Wordx3
    /// - returns: Word multiplier for this square.
    var wordMultiplier: Int {
        switch (self) {
        case .Center, .Wordx2: return 2
        case .Wordx3: return 3
        default: return 1
        }
    }
    /// - returns: Letter multiplier for this square.
    var letterMultiplier: Int {
        switch (self) {
        case .Letterx2: return 2
        case .Letterx3: return 3
        default: return 1
        }
    }
}

public func == (lhs: Square, rhs: Square) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}

public final class Square: CustomDebugStringConvertible, Equatable {
    /// - returns: Square array.
    class func createSquares() -> [[Square]] {
        var squares = [[Square]]()
        let m = PapyrusMiddle
        for row in 1...PapyrusDimensions {
            var line = [Square]()
            for col in 1...PapyrusDimensions {
                var mod: Modifier = .None
                func plusMinus(offset: Int, _ n: Int) -> Bool {
                    return offset == m - n || offset == m + n
                }
                func tuples(arr: [(Int, Int)]) -> Bool {
                    for (x, y) in arr {
                        if (plusMinus(row, x) && plusMinus(col, y)) ||
                            (plusMinus(col, x) && plusMinus(row, y)) {
                            return true
                        }
                    }
                    return false
                }
                func numbers(arr: [Int]) -> Bool {
                    for n in arr {
                        if plusMinus(row, n) && plusMinus(col, n) {
                            return true
                        }
                    }
                    return false
                }
                
                if row == PapyrusMiddle && col == PapyrusMiddle {
                    mod = .Center
                } else if numbers([3,4,5,6]) {
                    mod = .Wordx2
                } else if numbers([2]) || tuples([(2,6)]) {
                    mod = .Letterx3
                } else if numbers([1]) || tuples([(1,5), (0,4), (m-1, 4)]) {
                    mod = .Letterx2
                } else if numbers([m-1]) || tuples([(0, m-1)]) {
                    mod = .Wordx3
                }
                
                line.append(Square(mod, row: row - 1, column: col - 1))
            }
            squares.append(line)
        }
        return squares
    }
    public let row: Int
    public let column: Int
    public let type: Modifier
    public var tile: Tile?
    private init(_ type: Modifier, row: Int, column: Int) {
        self.type = type
        self.row = row
        self.column = column
    }
    public var debugDescription: String {
        return String("\(row),\(column)")
    }
    /// - returns: Letter multiplier for this tile.
    public var letterValue: Int {
        guard let tile = tile else { return 0 }
        return (tile.placement == .Fixed ? 1 : type.letterMultiplier) * tile.value
    }
    /// - returns: Word multiplier for this tile.
    public var wordMultiplier: Int {
        guard let tile = tile else { return 0 }
        return (tile.placement == .Fixed ? 1 : type.wordMultiplier)
    }
}

extension Papyrus {
    /// - parameter position: Position to check.
    /// - returns: Square at given position.
    public func squareAt(position: Position?) -> Square? {
        guard let pos = position else { return nil }
        if pos.horizontal {
            return squares[pos.fixed][pos.iterable]
        } else {
            return squares[pos.iterable][pos.fixed]
        }
    }
    
    /// - parameter boundary: Boundary to check.
    /// - returns: All squares in a given boundary.
    public func squaresIn(boundary: Boundary) -> [Square] {
        return boundary.positions().mapFilter({ squareAt($0) })
    }
}

