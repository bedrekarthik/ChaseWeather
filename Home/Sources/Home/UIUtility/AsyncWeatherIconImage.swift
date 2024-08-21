//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import SwiftUI
import Core

struct AsyncWeatherIconImage: View {
    let url: URL?
    
    var body: some View {
        VStack {
            AsyncImage(url: url) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: Tokens.Size.size40, height: Tokens.Size.size40)
        }
    }
}
