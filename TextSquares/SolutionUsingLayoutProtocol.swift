//
//  SolutionUsingLayoutProtocol.swift
//  TextSquares
//
//  Created by Gene Bogdanovich on 15.11.23.
//

import SwiftUI

struct EqualSquaresHStack: Layout {
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
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        return preferredSize(subviews: subviews, proposedWidth: proposal.width)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let height = preferredSize(subviews: subviews, proposedWidth: bounds.width).height
        var point = bounds.origin
        for subview in subviews {
            let placementProposal = ProposedViewSize(width: height, height: height)
            subview.place(at: point, proposal: placementProposal)
            point = CGPoint(x: point.x + height + spacing, y: point.y)
        }
    }
}

struct SolutionUsingLayoutProtocol: View {
    let sets = [1,3,6,8,12,16,23,43,56,76,100,101,125]
    
    var body: some View {
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                EqualSquaresHStack {
                    ForEach(sets, id: \.self) { set in
                        Text("\(set)")
                            .padding(8)
                        
                    }
                }
                .hidden()
                .overlay {
                    HStack(spacing: 10) {
                        ForEach(sets, id: \.self) { set in
                            Text("\(set)")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.blue)
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
    SolutionUsingLayoutProtocol()
}
