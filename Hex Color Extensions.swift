//
//  Color Extensions.swift
//  Hash Validator
//
//  Created by Ben Leggiero on 2017-05-05.
//  Copyright © 2017 Ben Leggiero. All rights reserved.
//

import AppKit.NSColor



private let nibblePattern = "[0-9A-F]"
private let bytePattern = "\(nibblePattern){2}"



public extension NSColor {
    
    enum BehaviorWithoutAlpha {
        case assumeFullyTransparent
        case assumeFullyOpaque
        case setTo(explicitValue: CGFloat)
        
        var backupFloat: CGFloat {
            switch self {
            case .assumeFullyOpaque: return 1.0
            case .assumeFullyTransparent: return 0.0
            case .setTo(let explicitValue): return explicitValue
            }
        }
    }
    
    
    
    convenience init?(hexString: String, behaviorWithoutAlpha: BehaviorWithoutAlpha = .assumeFullyOpaque) {
        
        guard let hexColorString = HexColorString(hexString) else {
            assertionFailure("Failed to turn \"\(hexString)\" into a color")
            return nil
        }
        
        guard let red = hexColorString.redFloat,
            let green = hexColorString.greenFloat,
            let blue = hexColorString.blueFloat else {
                assertionFailure("Failed to turn \(hexColorString) into its component values")
                return nil
        }
        
        let alpha = hexColorString.alphaFloat ?? behaviorWithoutAlpha.backupFloat
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}



public struct HexColorString {
    
    let red: String
    let green: String
    let blue: String
    let alpha: String?
    
    let kind: Kind
    
    enum Kind {
        case rgbNibbles
        case rgbaNibbles
        case rgbBytes
        case rgbaBytes
        
        static let all = [rgbNibbles, rgbaNibbles, rgbBytes, rgbaBytes]
    }
}

extension HexColorString {
    
    init?(_ hexString: String) {
        let stringRange = NSRange(0..<hexString.characters.count)
        for kind in Kind.all {
            let regex = kind.regex
            guard let match = regex.matches(in: hexString, options: [], range: stringRange).first else {
                continue
            }
            
            self.kind = kind
            (self.red, self.green, self.blue, self.alpha) = kind.rgba(from: match, in: hexString)
            
            return
        }
        
        return nil
    }
    
    
    var redFloat: CGFloat? { return kind.parseToFloat(red) }
    var greenFloat: CGFloat? { return kind.parseToFloat(green) }
    var blueFloat: CGFloat? { return kind.parseToFloat(blue) }
    var alphaFloat: CGFloat? {
        if let alpha = alpha {
            return kind.parseToFloat(alpha)
        } else {
            return nil
        }
    }
}

extension HexColorString.Kind {
    private static let hexColorStringPatterns = [
        HexColorString.Kind.rgbNibbles : "^#?(\(nibblePattern))(\(nibblePattern))(\(nibblePattern))$",
        HexColorString.Kind.rgbaNibbles : "^#?(\(nibblePattern))(\(nibblePattern))(\(nibblePattern))(\(nibblePattern))$",
        HexColorString.Kind.rgbBytes : "^#?(\(bytePattern))(\(bytePattern))(\(bytePattern))$",
        HexColorString.Kind.rgbaBytes : "^#?(\(bytePattern))(\(bytePattern))(\(bytePattern))(\(bytePattern))$"
    ]
    
    
    var usesAlpha: Bool {
        switch self {
        case .rgbaNibbles, .rgbaBytes: return true
        case .rgbNibbles, .rgbBytes: return false
        }
    }
    
    
    var regexPattern: String {
        guard let pattern = HexColorString.Kind.hexColorStringPatterns[self] else {
            assertionFailure("Could not create regular expression pattern!")
            return ""
        }
        return pattern
    }
    
    
    var regex: NSRegularExpression {
        guard let regex = try? NSRegularExpression(pattern: regexPattern, options: .caseInsensitive) else {
            assertionFailure("Could not create regular expression: /\(regexPattern)/i")
            return NSRegularExpression()
        }
        return regex
    }
    
    
    var maxIntPerColor: Int {
        switch self {
        case .rgbNibbles, .rgbaNibbles: return 0xF
        case .rgbBytes, .rgbaBytes: return 0xFF
        }
    }
    
    
    func parseToFloat(_ colorString: String) -> CGFloat? {
        guard let intVal = parseToInt(colorString) else {
            assertionFailure("Failed to turn \(colorString) into a float")
            return nil
        }
        return CGFloat(intVal) / CGFloat(self.maxIntPerColor)
    }
    
    
    func parseToInt(_ colorString: String) -> Int? {
        guard let intVal = Int(colorString, radix: 0x10) else {
            assertionFailure("Failed to turn \(colorString) into an int")
            return nil
        }
        return intVal
    }
    
    
    func rgba(from regexMatch: NSTextCheckingResult, in hexString: String) -> (String, String, String, String?) {
        let red: String
        let green: String
        let blue: String
        let alpha: String?
        var range: NSRange
        
        range = regexMatch.rangeAt(1)
        red = hexString.substring(with: range)
        
        range = regexMatch.rangeAt(2)
        green = hexString.substring(with: range)
        
        range = regexMatch.rangeAt(3)
        blue = hexString.substring(with: range)
        
        if usesAlpha {
            range = regexMatch.rangeAt(4)
            alpha = hexString.substring(with: range)
        } else {
            alpha = nil
        }
        
        return (red, green, blue, alpha)
    }
}



private extension String {
    func substring(with nsRange: NSRange) -> String {
        let start = self.index(self.startIndex, offsetBy: nsRange.location)
        let end = self.index(self.startIndex, offsetBy: nsRange.location + nsRange.length)
        
        return self[start..<end]
    }
}
