//
//  Player.swift
//  PapyrusCore
//
//  Created by Chris Nevin on 8/07/2015.
//  Copyright © 2015 CJNevin. All rights reserved.
//

import Foundation

public func == (lhs: Player, rhs: Player) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}

public enum Difficulty {
    case Human
    case Newbie
    case Average
    case Champion
}

/// An instance of a Player which has a score and can be assigned to tiles.
/// - SeeAlso: Papyrus.player is the current Player.
public final class Player: Equatable {
    public internal(set) var difficulty: Difficulty
    /// Players current score.
    public internal(set) var score: Int = 0
    /// All tiles played by this player.
    public internal(set) lazy var tiles = Set<Tile>()
    /// Current rack tiles.
    public var rackTiles: [Tile] {
        return tiles.filter({$0.placement == Placement.Rack})
    }
    /// Current play tiles, i.e. tiles on the board that haven't been submitted yet.
    public var currentPlayTiles: [Tile] {
        return tiles.filter({$0.placement == Placement.Board})
    }
    /// Currently held tile, i.e. one being dragged around.
    public var heldTile: Tile? {
        let held = tiles.filter({$0.placement == Placement.Held})
        assert(held.count < 2)
        return held.first
    }
    /// Method to return first rack tile with a given letter.
    func firstRackTile(withLetter letter: Character) -> Tile? {
        return rackTiles.filter({$0.letter == letter}).first
    }
    public init(score: Int? = 0, difficulty: Difficulty = .Human) {
        self.score = score!
        self.difficulty = difficulty
    }
}

extension Papyrus {
    /// - returns: A new player with their rack pre-filled. Or an error if refill fails.
    public func createPlayer(difficult: Difficulty = .Human) -> Player {
        let newPlayer = Player()
        replenishRack(newPlayer)
        players.append(newPlayer)
        return newPlayer
    }
    /// Advances to next player's turn.
    public func nextPlayer() {
        playerIndex++
        if playerIndex >= players.count {
            playerIndex = 0
        }
        lifecycleCallback?(.ChangedPlayer, self)
    }
    /// Add tiles to a players rack from the bag.
    /// - returns: Number of tiles able to be drawn for a player.
    func replenishRack(player: Player) -> Int {
        let needed = PapyrusRackAmount - player.rackTiles.count
        var count = 0
        for i in 0..<tiles.count where tiles[i].placement == .Bag && count < needed {
            tiles[i].placement = .Rack
            player.tiles.insert(tiles[i])
            count++
        }
        return count
    }
    
    /// Move tiles from a players rack to the bag.
    func returnTiles(tiles: [Tile], forPlayer player: Player) {
        player.tiles.subtractInPlace(tiles)
        tiles.forEach({$0.placement = .Bag})
    }
}