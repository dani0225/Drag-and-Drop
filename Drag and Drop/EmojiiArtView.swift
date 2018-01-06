//
//  EmojiiArtView.swift
//  Drag and Drop
//
//  Created by Admin on 05/01/2018.
//  Copyright © 2018 home. All rights reserved.
//

import UIKit

class EmojiiArtView: UIView {

    var backgroundImage: UIImage?
    {
        didSet
            {
             setNeedsDisplay()
            }
    }
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        backgroundImage?.draw(in: bounds)
    }
   

}
