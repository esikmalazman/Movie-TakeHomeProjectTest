//
//  ReusableXIB.swift
//  Movie+
//
//  Created by Ikmal Azman on 23/06/2023.
//

import Foundation
import UIKit.UINib

protocol ReusableXIB : AnyObject {
    static var identifier : String {get}
    static func nib() -> UINib
}

extension ReusableXIB {
    static var identifier : String {
        return "\(self)"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: .main)
    }
}
