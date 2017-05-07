//
//  Color Extensions Tests.swift
//  Hash Validator
//
//  Created by Ben Leggiero on 2017-05-06.
//  Copyright © 2017 Ben Leggiero. All rights reserved.
//

import XCTest

class Color_Extensions_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testInitWithHexColor() {
        guard let materialGreenWithPoundSign = NSColor(hexString: "#4CAF50") else {// rgb(76,175,80)
            XCTAssert(false, "Could not create material green 500")
            return
        }
        
        XCTAssert(equal(materialGreenWithPoundSign.redComponent, 0x4C/255.0))
        XCTAssert(equal(materialGreenWithPoundSign.greenComponent, 0xAF/255.0))
        XCTAssert(equal(materialGreenWithPoundSign.blueComponent, 0x50/255.0))
        XCTAssert(equal(materialGreenWithPoundSign.alphaComponent, 1))
        
        
        guard let semitransparentMaterialGreenWithPoundSign = NSColor(hexString: "#4CAF507F") else {// rgba(76,175,80,0.5)
            XCTAssert(false, "Could not create semitransparent material green 500")
            return
        }
        
        XCTAssert(equal(semitransparentMaterialGreenWithPoundSign.redComponent, 0x4C/255.0))
        XCTAssert(equal(semitransparentMaterialGreenWithPoundSign.greenComponent, 0xAF/255.0))
        XCTAssert(equal(semitransparentMaterialGreenWithPoundSign.blueComponent, 0x50/255.0))
        XCTAssert(equal(semitransparentMaterialGreenWithPoundSign.alphaComponent, 0.5))
        
        
        guard let materialGreenWithoutPoundSign = NSColor(hexString: "4CAF50") else {// rgb(76,175,80)
            XCTAssert(false, "Could not create material green 500")
            return
        }
        
        XCTAssert(equal(materialGreenWithoutPoundSign.redComponent, 0x4C/255.0))
        XCTAssert(equal(materialGreenWithoutPoundSign.greenComponent, 0xAF/255.0))
        XCTAssert(equal(materialGreenWithoutPoundSign.blueComponent, 0x50/255.0))
        XCTAssert(equal(materialGreenWithoutPoundSign.alphaComponent, 1))
        
        
        guard let semitransparentMaterialGreenWithoutPoundSign = NSColor(hexString: "4CAF507F") else {// rgba(76,175,80, 0.5)
            XCTAssert(false, "Could not create semitransparent material green 500")
            return
        }
        
        XCTAssert(equal(semitransparentMaterialGreenWithoutPoundSign.redComponent, 0x4C/255.0))
        XCTAssert(equal(semitransparentMaterialGreenWithoutPoundSign.greenComponent, 0xAF/255.0))
        XCTAssert(equal(semitransparentMaterialGreenWithoutPoundSign.blueComponent, 0x50/255.0))
        XCTAssert(equal(semitransparentMaterialGreenWithoutPoundSign.alphaComponent, 0.5))
        
        
        guard let threeNibbleMagentaWithPoundSign = NSColor(hexString: "#B27") else {// rgba(187,34,119)
            XCTAssert(false, "Could not create Silly Magenta")
            return
        }
        
        XCTAssert(equal(threeNibbleMagentaWithPoundSign.redComponent, 0xB/0xF))
        XCTAssert(equal(threeNibbleMagentaWithPoundSign.greenComponent, 0x2/0xF))
        XCTAssert(equal(threeNibbleMagentaWithPoundSign.blueComponent, 0x7/0xF))
        XCTAssert(equal(threeNibbleMagentaWithPoundSign.alphaComponent, 1))
        
        
        guard let semitransparentThreeNibbleMagentaWithPoundSign = NSColor(hexString: "#B278") else {// rgba(187,34,119, 0.5)
            XCTAssert(false, "Could not create semitransparent Silly Magenta")
            return
        }
        
        XCTAssert(equal(semitransparentThreeNibbleMagentaWithPoundSign.redComponent, 0xB/0xF))
        XCTAssert(equal(semitransparentThreeNibbleMagentaWithPoundSign.greenComponent, 0x2/0xF))
        XCTAssert(equal(semitransparentThreeNibbleMagentaWithPoundSign.blueComponent, 0x7/0xF))
        XCTAssert(equal(semitransparentThreeNibbleMagentaWithPoundSign.alphaComponent, 0x8/0xF))
        
        
        guard let threeNibbleMagentaWithoutPoundSign = NSColor(hexString: "B27") else {// rgba(187,34,119)
            XCTAssert(false, "Could not create Silly Magenta")
            return
        }
        
        XCTAssert(equal(threeNibbleMagentaWithoutPoundSign.redComponent, 0xB/0xF))
        XCTAssert(equal(threeNibbleMagentaWithoutPoundSign.greenComponent, 0x2/0xF))
        XCTAssert(equal(threeNibbleMagentaWithoutPoundSign.blueComponent, 0x7/0xF))
        XCTAssert(equal(threeNibbleMagentaWithoutPoundSign.alphaComponent, 1))
        
        
        guard let semitransparentThreeNibbleMagentaWithoutPoundSign = NSColor(hexString: "B278") else {// rgba(187,34,119, 0.5)
            XCTAssert(false, "Could not create semitransparent Silly Magenta")
            return
        }
        
        XCTAssert(equal(semitransparentThreeNibbleMagentaWithoutPoundSign.redComponent, 0xB/0xF))
        XCTAssert(equal(semitransparentThreeNibbleMagentaWithoutPoundSign.greenComponent, 0x2/0xF))
        XCTAssert(equal(semitransparentThreeNibbleMagentaWithoutPoundSign.blueComponent, 0x7/0xF))
        XCTAssert(equal(semitransparentThreeNibbleMagentaWithoutPoundSign.alphaComponent, 0x8/0xF))
    }
}



@inline(__always)
private func equal(_ actual: CGFloat,
                   _ expected: CGFloat,
                   tolerance: CGFloat = 0.01) -> Bool {
    if abs(expected - actual) > tolerance {
        print("❌ \(actual) is not \(tolerance) away from \(expected)")
        return false
    } else {
        return true
    }
}
