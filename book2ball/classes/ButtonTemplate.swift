//
//  ButtonTemplate.swift
//  book2ball
//
//  Created by Admin on 2018-11-21.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

@IBDesignable //interface builder
class ButtonTemplate: UIButton {
    
    //allow this property to be shown in the attribute inspector
    @IBInspectable var corderRadius: CGFloat = 0 {
        //when property change in the storyboard
        //set it
        didSet{
            self.layer.cornerRadius = corderRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
