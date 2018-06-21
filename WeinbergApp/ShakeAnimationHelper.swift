//
//  ShakeAnimationHelper.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 16.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import UIKit

class ShakeAnimationHelper{

 
    
    public func shake(centerOfControl: CGPoint, intensity: Double? = nil,duration: Double? = nil) -> CABasicAnimation {
        
        
            let keyPath = "position"
            let movement = intensity ?? 6.0
            let animation = CABasicAnimation(keyPath: keyPath)
            animation.duration = duration ?? 0.09
            animation.repeatCount = 4
            animation.autoreverses = true
            
        
            animation.fromValue = NSValue(cgPoint: CGPoint(x: centerOfControl.x - CGFloat(movement),
                                                           y: centerOfControl.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: centerOfControl.x + CGFloat(movement),
                                                         y: centerOfControl.y))
        
            return animation
    }
    
}
