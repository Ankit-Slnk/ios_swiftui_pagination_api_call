//
//  Utility.swift
//  ios-swiftui-pagination-api-call
//
//  Created by Ankit Solanki on 25/11/20.
//

import Foundation
import SwiftUI

class Utility {
    
    static var screenSize: CGSize {
        #if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.size
        #else
        return NSScreen.main?.frame.size ?? .zero
        #endif
    }
    
    static func toast(text: String) -> some View {
        VStack() {
            Text(text)
                .lineLimit(2)
                .font(.system(size: 16))
                .foregroundColor(.white)
        }
        .padding(15)
        .frame(width: screenSize.width, height: 100)
        .background(Color.black)
        
    }
}
