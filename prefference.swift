//
//  prefference.swift
//  reserveAppSwiftUI
//
//  Created by Иван Терехов on 24.01.2025.
//

import Foundation

import SwiftUI

struct OffsetKey: PreferenceKey{
   static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat){
        value = nextValue()
    }
    
}


