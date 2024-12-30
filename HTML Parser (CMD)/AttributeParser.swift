//
//  AttributeParser.swift
//  HTML Parser (CMD)
//
//  Created by Chidume Nnamdi on 28/12/2024.
//

import Foundation

class AttributeParser {
    var attr: String = "";
    var isValue = false;
    var isKey = true;
    var value = ""
    var key = ""
    var openKeyString = false;
    var attrs: [Attributes] = []
    
    init(attr: String) {
        self.attr = attr;
    }
    
    func start() -> [Attributes] {
        
        for (index, char) in attr.enumerated() {
            
            guard let nextChar = attr.nextChar(index) else {
                break
            }
            
            if (char == "=") {
                // set isValue to true
                isValue = true
                isKey = false;
                continue;
            }
            
            if (char == "'" && !isAlphanumeric(String(nextChar))) {
                isValue = false;
                isKey = true;
                
                self.attrs += [Attributes(name: key, value: value)]
                continue;
            }
            
            if (isKey) {
                key += String(char)
                continue
            }
            
            if (isValue) {
                value += String(char);
                
                if (!isAlphanumeric(String(nextChar))) {
                    
                    isValue = false
                    
                }
                
                continue
            }
            
        }
        
        return attrs
        
    }
}
