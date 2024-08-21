//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import SwiftUI

struct LocationHeaderTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 46))
            .fontWeight(.medium)
            .foregroundStyle(.white)
    }
}

struct LocationHeaderTemperature: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 62))
            .fontWeight(.regular)
            .foregroundStyle(.white)
    }
}

struct LocationHeaderStatus: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
    }
}
