//
//  Papyrus.swift
//  PapyrusCore
//
//  Created by Chris Nevin on 8/07/2015.
//  Copyright © 2015 CJNevin. All rights reserved.
//

import Foundation

public let PapyrusRackAmount: Int = 7
public let PapyrusDimensions: Int = 15
let PapyrusMiddle: Int = 8

public typealias LifecycleCallback = (Lifecycle, Papyrus) -> ()

public enum Lifecycle {
    case Cleanup
    case Preparing
    case Ready
    case ChangedPlayer
    case EndedTurn
    case Completed
    case NoMoves
}

public final class Papyrus {
    public static var dawg: Dawg?
    public var dawg: Dawg? {
        return Papyrus.dawg
    }
    
    var lifecycleCallback: LifecycleCallback?
    public internal(set) var lifecycle: Lifecycle?
    public internal(set) var inProgress: Bool = false
    public let squares: [[Square]]
    
    lazy var tiles = [Tile]()
    
    public internal(set) lazy var players = [Player]()
    public internal(set) var playerIndex: Int = 0
    public var player: Player? {
        if players.count <= playerIndex { return nil }
        return players[playerIndex]
    }
    
    public init() {
        squares = Square.createSquares()
    }
    
    /// Create a new game.
    /// - parameter callback: Callback which will be called throughout all stages of game lifecycle.
    public func newGame(callback: LifecycleCallback) {
        squares.flatten().forEach({$0.tile = nil})
        inProgress = true
        lifecycleCallback?(.Cleanup, self)
        lifecycleCallback = callback
        lifecycleCallback?(.Preparing, self)
        tiles.removeAll()
        players.removeAll()
        playerIndex = 0
        tiles.appendContentsOf(Tile.createTiles())
        lifecycleCallback?(.Ready, self)
    }
    
    public func changeState(state: Lifecycle) {
        lifecycle = state
        lifecycleCallback?(state, self)
    }
}