//
//  ViewFader.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 09.07.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import UIKit

class ViewFader {
    
    public enum FadeMode{
        case IN
        case OUT
    }

    /// Lässt eine View Ein- oder Ausfaden
    ///
    /// - Parameters:
    ///   - mode: Entscheider, ob Ein- oder Ausgefadet wird
    ///   - view: Die zu fadende View
    public func fade(mode: FadeMode, view: UIView){
        if(mode == FadeMode.IN){
            view.alpha = 0
            view.isHidden = false
            UIView.animate(withDuration: 0.5) {
                view.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                view.alpha = 0
            }) { (finished) in
                view.isHidden = finished
            }

        }
        
    }

}
