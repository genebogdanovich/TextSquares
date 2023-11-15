//
//  SolutionUsingLayoutProtocolAndGeometryReader.swift
//  TextSquares
//
//  Created by Gene Bogdanovich on 10.11.23.
//

import SwiftUI

struct HStackEqualSquares: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        preferredSize(subviews: subviews, proposedWidth: proposal.width)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let height = preferredSize(subviews: subviews, proposedWidth: bounds.width).height
        var point = bounds.origin
        for subview in subviews {
            let placementProposal = ProposedViewSize(width: height, height: height)
            subview.place(at: point, proposal: placementProposal)
            point = CGPoint(x: point.x + height + spacing, y: point.y)
        }
    }
    
    var spacing: CGFloat = 10
    
    private func preferredSize(subviews: Subviews, proposedWidth: CGFloat?) -> CGSize {
        let subviewDimensions = subviews.map { $0.dimensions(in: .unspecified) }
        let maxWidth: CGFloat = subviewDimensions.reduce(.zero) { currentMax, subviewSize in
            max(currentMax, subviewSize.width)
        }
        let nSubviews = CGFloat(subviews.count)
        let totalWidth = (nSubviews * maxWidth) + ((nSubviews - 1) * spacing)
        return CGSize(width: totalWidth, height: maxWidth)
    }
    
}

struct SolutionUsingLayoutProtocolAndGeometryReader: View {
    let sets = [1,3,6,8,12,16,23,43,56,76,100,101,125]
    
    private var simpleFootprint: some View {
        Text("888")
            .hidden()
    }
    
    var body: some View {
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStackEqualSquares {
                    ForEach(sets, id: \.self) { set in
                        simpleFootprint
                            .padding(4)
                            .overlay {
                                GeometryReader { proxy in
                                    let width = proxy.size.width
                                    Text("\(set)")
                                        .frame(width: width, height: width)
                                        .background(.blue)
                                    
                                }
                            }
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

#Preview {
    SolutionUsingLayoutProtocolAndGeometryReader()
}
