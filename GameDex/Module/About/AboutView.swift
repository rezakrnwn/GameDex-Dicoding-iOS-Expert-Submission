//
//  AboutView.swift
//  GameDex
//
//  Created by Reza Kurniawan on 29/03/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack {
                    Image("Reza")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .cornerRadius(8)
                    Text("Reza Kurniawan")
                        .fontWeight(.bold)
                    Text("Version 1.0.0")
                        .font(.caption)
                }
            }
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AboutView()
}
