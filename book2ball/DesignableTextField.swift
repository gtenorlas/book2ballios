//
//  DesignableTextField.swift
//  book2ball
//
//  Created by moghid saad on 2018-11-19.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    @IBInspectable var leftImage: UIImage?{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0{
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        if let image = leftImage {
          leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.tintColor = tintColor
            
            var width = leftPadding + 20
            
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line{
                width = width + 5
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            
            leftView = view
        }else {
            //image is nill
            leftViewMode = .never
        }
    }

}
