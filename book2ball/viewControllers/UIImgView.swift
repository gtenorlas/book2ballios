//
//  UIImgView.swift
//  book2ball
//
//  Created by moghid saad on 2018-11-19.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        self.layer.borderWidth = 2
    }
}
