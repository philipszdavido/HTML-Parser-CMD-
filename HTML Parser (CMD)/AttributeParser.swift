//
//  AttributeParser.swift
//  HTML Parser (CMD)
//
//  Created by Chidume Nnamdi on 28/12/2024.
//

import Foundation

class AttributeParser {
    
    var attr: String = "";
    var attrs: [Attributes] = []
    
    init(attr: String) {
        self.attr = attr;
    }
    
    func start() -> [Attributes] {
        
        let tokens = tokenize();
        
        for (index, token) in tokens.enumerated() {
            
            let nextToken = tokens[index + 1];
            
            if (nextToken != "=") {
                
                attrs += [Attributes(name: String(token))]
                
                continue;
            }
                        
        }
        
        return attrs
        
    }
    
    func tokenize() -> [String] {
        
        var seenQuotes = false;
        var attrs: [String] = [];
        var concat = ""
        
        for (_, char) in attr.enumerated() {
                        
            if (char.containsQuotes() && !seenQuotes) {
                seenQuotes = true;
            } else if (char.containsQuotes() && seenQuotes) {
                seenQuotes = false;
            }
            
            if (char == " " && !seenQuotes) {
                attrs += [concat];
                concat = "";
                continue;
            }
            
            if (char == "=" && !seenQuotes) {
                attrs += [concat, String(char)];
                concat = "";
                continue;
            }
            
            concat += String(char);
            
        }
        
        attrs += [concat];
        concat = "";
        
        return attrs.filter { currentAttr in
            !currentAttr.isEmpty
        };
    }
    
}
