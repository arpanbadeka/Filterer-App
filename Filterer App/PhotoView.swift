//
//  PhotoView.swift
//  Filterer App
//
//  Created by Arpan Badeka on 2/5/16.
//  Copyright © 2016 abc. All rights reserved.
//

import UIKit

class PhotoView: UIImageView {
    var lastTouchTime: NSData? = nil
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
         super.touchesMoved(touches, withEvent: event)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
         super.touchesEnded(touches, withEvent: event)
        
        //let currentTime = NSData()
        //if let previousTime = lastTouchTime{
            //if let currentTime.timeIntervalSinceDate(previousTime) < 0.5 {
                
        //}
        //}
    }
    
    
}
