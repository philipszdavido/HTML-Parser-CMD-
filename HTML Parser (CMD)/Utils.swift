//
//  Utils.swift
//  HTML Parser (CMD)
//
//  Created by Chidume Nnamdi on 29/12/2024.
//

import Foundation

func isAlphanumeric(_ value: String) -> Bool {
    let alphanumericSet = CharacterSet.alphanumerics
    return value.unicodeScalars.allSatisfy { alphanumericSet.contains($0) }
}
