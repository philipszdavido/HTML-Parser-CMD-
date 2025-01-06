//
//  Parser.swift
//  HTML Parser (CMD)
//
//  Created by Chidume Nnamdi on 28/12/2024.
//

import Foundation

class Tokenizer {
    
    var openTag = false;
    var DOCTYPE = false;
    var collectAttrs = false;
    var attrs = "";
    var elementName: String = "";
    var text: String = "";
    var tokens: [Token] = [];
    var html: String = "";
    
    init(html: String) {
        self.html = html;
    }
    
    func tokenize() -> [Token] {
        
        for (index, char) in html.enumerated() {
            
            guard let nextChar = self.nextChar(index: index) else {
                break;
            };
            
            if (char == "<") {
                
                if(nextChar == "!") {
                    
                    // check for doctype
                    if(self.nextChar(index: index + 2)! == "D") {
                        self.DOCTYPE = true;
                        continue;
                    }
                    
                }
                
                self.openTag = true;
                continue;
            }
            
            if(self.DOCTYPE) {
                if(char == ">") {
                    self.DOCTYPE = false;
                    continue;
                }
                continue;
            }
            
            if(self.openTag) {
                
                if(self.collectAttrs) {
                    
                    self.attrs += String(char);
                    if(nextChar == ">") {
                        self.collectAttrs = false;
                    }
                    continue;
                }
                            
                if(char == " " && collectAttrs == false) {
                    // collect attributes
                    self.collectAttrs = true
                    continue
                }
                
                if(char == ">") {
                    
                    // process attributes
                    let attributes = self.processAttr(attrs: self.attrs);

                    if(self.elementName.starts(with: "/")) {
                        self.tokens += [Token(index: self.tokens.count, name: self.elementName, startTag: false, endTag: true, attributes: attributes, type: NodeType.Node)];
                        self.attrs = "";
                    } else {
                        self.tokens += [
                            Token(index: self.tokens.count, name: self.elementName, startTag: true, endTag: false, attributes: attributes, type: NodeType.Node)
                        ];
                        self.attrs = "";
                    }
                    
                    self.elementName = "";
                    self.openTag = false;
                    continue;
                }
                
                self.elementName += String(char);
                
            }
            
            if(self.openTag == false && self.DOCTYPE == false) {
                
                
                // process text
                self.text += String(char);
                if(nextChar == ">" || nextChar == "<") {
                    self.tokens += [Token(index: self.tokens.count, name: self.text, startTag: false, endTag: false, type: NodeType.Text)]
                    self.text = ""
                    continue;
                }
                                
            }
        
        }
        
        return self.tokens
        
    }
    
    func nextChar(index: Int) -> Character? {
        
        if(html.count <= index + 1) {
            return nil;
        }
        
        let stringIndex = String.Index(utf16Offset: index, in: html)
            
        let currentIndex = html.index(stringIndex, offsetBy: 1);
        return html[currentIndex]
        
    }
    
    func processAttr(attrs: String) -> [Attributes] {
        let attrParser = AttributeParser(attr: attrs)
        return attrParser.start()
    }
    
}
