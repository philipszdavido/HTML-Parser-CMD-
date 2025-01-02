//
//  extensions.swift
//  HTML Parser (CMD)
//
//  Created by Chidume Nnamdi on 02/01/2025.
//

import Foundation

extension String {
    
    func nextChar(_ index: Int) -> Character? {
        if(self.count <= index + 1) {
            return nil;
        }
        
        let stringIndex = String.Index(utf16Offset: index, in: self)
            
        let currentIndex = self.index(stringIndex, offsetBy: 1);
        return self[currentIndex]

    }
    
}

extension Character {
    func containsQuotes() -> Bool {
        return self == ("\"") || self == ("'")
    }
    
    func isAlphanumeric() -> Bool {
        let alphanumericSet = CharacterSet.alphanumerics
        return self.unicodeScalars.allSatisfy { alphanumericSet.contains($0) }
    }
    
    func isEmpty() -> Bool {
        return String(self) == " "
    }

}
