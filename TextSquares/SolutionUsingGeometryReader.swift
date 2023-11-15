//
//  SolutionUsingGeometryReader.swift
//  TextSquares
//
//  Created by Gene Bogdanovich on 15.11.23.
//

import SwiftUI

struct SolutionUsingGeometryReader: View {
    @ScaledMetric(relativeTo: .body) private var bottomPadding: CGFloat = 10
    
    let sets = [1,3,6,8,12,16,23,43,56,76,100,101,125]
    
    private var simpleFootprint: some View {
        Text("888")
            .hidden()
    }
    
    var body: some View {
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(sets, id: \.self) { set in
                        simpleFootprint
                            .padding(8)
                            .overlay {
                                GeometryReader { proxy in
                                    let width = proxy.size.width
                                    Text("\(set)")
                                        .frame(width: width, height: width)
                                        .background(Color.blue)
                                    
                                }
                            }
                    }
                }
                .padding(.bottom, bottomPadding)
            }
            
            Color.green
                .overlay {
                    Text("56")
                        .font(.largeTitle.weight(.bold))
                }
        }
    }
}

#Preview {
    SolutionUsingGeometryReader()
}
