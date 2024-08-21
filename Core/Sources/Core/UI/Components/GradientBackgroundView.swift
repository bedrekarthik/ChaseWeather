//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import SwiftUI

public struct GradientBackgroundView: View {
    
    public init() {}
    
    public var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom
                ))
            .ignoresSafeArea()
    }
}
