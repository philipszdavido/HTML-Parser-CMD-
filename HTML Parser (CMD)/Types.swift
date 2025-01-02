//
//  Types.swift
//  HTML Parser (CMD)
//
//  Created by Chidume Nnamdi on 02/01/2025.
//

import Foundation

enum NodeType {
 case Node
 case Text
}

struct Attributes {
    var name: String;
    var value: String?;
}

struct Node {
    var name: String;
    var startTag: Bool?;
    var endTag: Bool?;
    var attributes: [Attributes]?;
    var type: NodeType;
}
