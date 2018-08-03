//
//  UIInputChecker.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 09.07.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import UIKit

class UIInputChecker{

    public enum UIInputType {
        case text
        case numer
    }
   
    init(){
        
    }
   
    /// Prüft eine Eingabe auf Buchstaben oder Ziffern
    ///
    /// - Parameters:
    ///   - input: Die zu prüfende Zeichenkette
    ///   - type: Gibt an, ob auf Buchstaben oder Ziffern geprüft werden soll
    /// - Returns: true, falls sämtliche Zeichen der Zeichenkette mit dem Prüftypen übereinstimmen; false sonst
    public func check(input: String, type: UIInputType) -> Bool{
        switch type {
        case UIInputType.text:
            return CharacterSet.alphanumerics.isSuperset(of: CharacterSet(charactersIn: input))
        case UIInputType.numer:
            return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: input))
        }
    }
    
}
