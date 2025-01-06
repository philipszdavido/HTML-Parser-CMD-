//
//  Parser.swift
//  HTML Parser (CMD)
//
//  Created by Chidume Nnamdi on 05/01/2025.
//

import Foundation

extension Array {
    func getElementsWithinIndexes(startIndex: Int, endIndex: Int) -> [Any] {
        var elements: [Any] = [];
        for (index, char) in self.enumerated() {
            if (index >= startIndex && index <= endIndex) {
                elements += [char]
            }
        }
        return elements
    }
}

class Parser {
    
    func start(tokens: [Token]) -> [ElementNode] {
        
        var rootNodes: [ElementNode] = [];
        var index = 0;
        
        while index < tokens.count {
            
            let token = tokens[index];
            
            if (token.self.type == NodeType.Text) {
                rootNodes += [Text(name: token.self.name)]
            }
            
            if (token.self.type == NodeType.Node) {
                var (closeToken, closingIndex) = findClosingTag(tokens, nodeName: token.self.name, startIndex: index + 1);
                let startIndex = index + 1;
                let endIndex = closingIndex!
                let children = self.start(tokens: Array(tokens[startIndex..<endIndex]));
                let element = Element(name: token.self.name, children: children, attributes: token.self.attributes)
                
                rootNodes += [element]
            }
            
            index += 1

        }
                
        return rootNodes
        
    }
    
    func findClosingTag(_ tokens: [Token], nodeName: String, startIndex: Int) -> (closeToken: Token?, closingIndex: Int?) {
        
        func wherePredicate(token: Token) -> Bool {
            return token.name == "/" + nodeName
        }
        
        let firstToken = tokens.first(where: wherePredicate);
        let firstTokenIndex = firstToken?.index;
        
        return (closeToken: firstToken, closingIndex: firstTokenIndex)
        
        
        
    }
    
    
}
