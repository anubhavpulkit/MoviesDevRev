//
//  ContentView.swift
//  MovieDevRev
//
//  Created by Anubhav Singh on 18/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MovieHomeView()
                .navigationTitle("DevRev")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
