//
//  TokenToHTML.swift
//  HTML Parser (CMD)
//
//  Created by Chidume Nnamdi on 05/01/2025.
//

import Foundation


class TokenToHTML {
    
    var html = ""
    
    func convertToHTML(tokens: [Token]) -> String {
        
        for token in tokens.enumerated() {
            
            if(token.element.type == NodeType.Text) {
                html += token.element.name
            }
            
            if (token.element.type == NodeType.Node) {
                
                html += "<" + token.element.name + ">"
            }
            
        }
        
        return html
        
    }
}
