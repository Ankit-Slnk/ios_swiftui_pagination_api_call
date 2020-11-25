//
//  Extensions.swift
//  ios-swiftui-pagination-api-call
//
//  Created by Ankit Solanki on 25/11/20.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}
