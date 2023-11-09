//
//  ContentView.swift
//  TextSquares
//
//  Created by Gene Bogdanovich on 9.11.23.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    
    let sets = [1,3,6,8,12,16,23,43,56,76,100,101,125]
    
    var body: some View {
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sets, id: \.self) { set in
                        Text("\(set)")
                            .padding(8)
                            .background(Color.blue)
                    }
                }
            }
            
            Color.green
                .overlay {
                    Text("56")
                        .font(.largeTitle.weight(.bold))
                }
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
