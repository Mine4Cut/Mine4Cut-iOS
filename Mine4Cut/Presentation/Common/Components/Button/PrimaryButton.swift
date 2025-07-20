//
//  PrimaryButton.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/20/25.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 49)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 40))
        }
    }
}
