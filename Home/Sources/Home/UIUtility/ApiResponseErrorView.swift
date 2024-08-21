//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import SwiftUI
import Core

struct ApiResponseErrorView: View {
    enum SizeType {
        case small
        case medium
        
        var frame: CGSize {
            switch self {
            case .small:
                return .init(width: Tokens.Size.size40, height: Tokens.Size.size40)
            case .medium:
                return .init(width: Tokens.Size.size80, height: Tokens.Size.size80)
            }
        }
    }
    
    let sizeType: SizeType
    let message: String
    
    init(sizeType: SizeType = .small, message: String = "") {
        self.sizeType = sizeType
        self.message = message
    }
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .foregroundStyle(.yellow)
                .frame(width: sizeType.frame.width, height: sizeType.frame.height)
                .fixedSize()
            Spacer(minLength: Tokens.Spacing.padding8)
            Text(message)
                .font(.callout)
                
        }
    }
}

#Preview {
    ApiResponseErrorView(sizeType: .small, message: "Error")
        .fixedSize(horizontal: true, vertical: true)
}

#Preview {
    ApiResponseErrorView(sizeType: .medium, message: "Error")
        .fixedSize(horizontal: true, vertical: true)
}

