//
//  ButtonStyle.swift
//  Hosty
//
//  Created by Ahmed Shaaban on 6/14/20.
//  Copyright © 2020 Shaabs. All rights reserved.
//

import Foundation
import SwiftUI

struct IconButtonStyle: ButtonStyle {
    var normalImage: Image
    var pressedImage: Image
    var width: CGFloat;
    var height: CGFloat;
    func makeBody(configuration: Self.Configuration) -> some View {
        
        return configuration.isPressed ? self.pressedImage.resizable().frame(width: self.width, height: self.height) : self.normalImage.resizable().frame(width: self.width, height: self.height)
    }
    
}

