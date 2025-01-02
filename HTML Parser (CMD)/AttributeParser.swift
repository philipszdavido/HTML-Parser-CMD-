//
//  AttributeParser.swift
//  HTML Parser (CMD)
//
//  Created by Chidume Nnamdi on 28/12/2024.
//

import Foundation

class AttributeParser {
    
    var attr: String = "";
    var attrs: [Attributes] = [];
    
    init(attr: String) {
        self.attr = attr;
    }
    
    func start() -> [Attributes] {
        
        let tokens = tokenize();
        
        print(tokens)
        
        for (index, token) in tokens.enumerated() {
                        
            var nextToken: String = "";
            
            if (index + 1 < tokens.count) {
                
                nextToken = tokens[index + 1];
                
            }
            
            if (token == "=") {
                
                attrs += [Attributes(name: String(tokens[index - 1]), value: String(nextToken))];
                continue;
                
            }

            if (nextToken != "=" && token != "=" && tokens[index - 1] != "=") {
                
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
