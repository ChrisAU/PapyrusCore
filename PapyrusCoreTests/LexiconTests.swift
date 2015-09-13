//
//  LexiconTests.swift
//  Papyrus
//
//  Created by Chris Nevin on 13/09/2015.
//  Copyright © 2015 CJNevin. All rights reserved.
//

import XCTest
@testable import PapyrusCore

class LexiconTests: XCTestCase {
    
    let lexicon: Lexicon = Lexicon(withFilePath: NSBundle(forClass: LexiconTests.self).pathForResource("CSW12", ofType: "plist")!)!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAnagrams() {
        var fixedLetters: [(Int, Character)] = []
        var results = [String]()
        lexicon.anagramsOf("CAT", length: 3, prefix: "",
            fixedLetters: fixedLetters, fixedCount: 0, root: lexicon.dictionary!, results: &results)
        XCTAssert(results.sort() == ["ACT", "CAT"])
        
        fixedLetters.append((2, "R"))
        results = [String]()
        lexicon.anagramsOf("TAC", length: 4, prefix: "",
            fixedLetters: fixedLetters, fixedCount: 1, root: lexicon.dictionary!, results: &results)
        XCTAssert(results == ["CART"])
        
        results = [String]()
        lexicon.anagramsOf("TACPOSW", length: 3, prefix: "",
            fixedLetters: fixedLetters, fixedCount: 1, root: lexicon.dictionary!, results: &results)
        XCTAssert(results.sort() == ["CAR", "COR", "OAR", "PAR", "SAR", "TAR", "TOR", "WAR"])
        
        results = [String]()
        lexicon.anagramsOf("PATIERS", length: 8, prefix: "",
            fixedLetters: fixedLetters, fixedCount: 1, root: lexicon.dictionary!, results: &results)
        XCTAssert(results == ["PARTIERS"])
        
        results = [String]()
        fixedLetters.append((0, "C"))
        lexicon.anagramsOf("AEIOU", length: 3, prefix: "",
            fixedLetters: fixedLetters, fixedCount: 1, root: lexicon.dictionary!, results: &results)
        XCTAssert(results.sort() == ["CAR", "COR", "CUR"])
    }

    func wrappedDefined(str: String) -> Bool {
        do {
            return !(try lexicon.defined(str).isEmpty)
        }
        catch {
            return false
        }
    }
    
    func testDefinitions() {
        XCTAssert(!wrappedDefined(""))
        XCTAssert(wrappedDefined("CAT"))
        XCTAssert(!wrappedDefined("CATX"))
        XCTAssert(!wrappedDefined("ACTPER"))
        XCTAssert(wrappedDefined("PERIODONTAL"))
        XCTAssert(wrappedDefined("PARTIER"))
        XCTAssert(!wrappedDefined("SUPERCALIFRAGILISTICEXPIALIDOCIOUS"))
    }
    
}
