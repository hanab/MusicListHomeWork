//
//  MusicListHomeWorkTests.swift
//  MusicListHomeWorkTests
//
//  Created by Hana  Demas on 02/07/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import MusicListHomeWork

class MusicListHomeWorkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // a small test to test if 10 objects are read from json file
    func testgetSongsFromJson() {
        let songs = Song.getSongsFromJson()
        XCTAssert(songs.count == 10, "more or less songs than expected \(songs.count)")
        
        let fiteredSongs = songs.filter { song in song.title == "Seasons in the sun" }.first
        guard let song = fiteredSongs else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(song.bandName == "West Life", "title not set")
        XCTAssert(song.songFileName == "seasonsInTheSun", "song file name not set")
        XCTAssert(song.imageUrl == "http://1.bp.blogspot.com/-J6ASPEwGSSg/TmeSwoCF0EI/AAAAAAAAAA4/WFyZGKD-Hgg/s1600/westlifegrentermainsite.png", "image url not set")
    }
    
    //a test to see if the random generated string is 200 in length
    func testRandomStringLength() {
        let str = String.random()
        XCTAssertEqual(str.characters.count, 200)
    }
}
