//
//  ImmersiveView.swift
//  booksp
//
//  Created by Takuzen Toh on 7/5/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var model = SearchViewModel()
    
    var body: some View {
        RealityView { content in
            content.add(model.setupContentEntity())
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
