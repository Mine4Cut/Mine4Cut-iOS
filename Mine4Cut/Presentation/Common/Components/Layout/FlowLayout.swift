//
//  FlowLayout.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/20/25.
//

import SwiftUI

struct FlowLayout: Layout {
    var horizontalSpacing: CGFloat
    var verticalSpacing: CGFloat
    
    init(horizontalSpacing: CGFloat = 8, verticalSpacing: CGFloat = 8) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }
}

extension FlowLayout {
    // 전체 크기 계산
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        return calculateLayout(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews
        ).totalSize
    }
    
    // 각 뷰의 위치 결정
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let result = calculateLayout(
            in: bounds.width,
            subviews: subviews
        )
        
        for (index, subview) in subviews.enumerated() {
            let frame = result.frames[index]
            let position = CGPoint(
                x: bounds.minX + frame.minX,
                y: bounds.minY + frame.minY
            )
            subview.place(at: position, proposal: .unspecified)
        }
    }
}

// MARK: - 레이아웃 계산
extension FlowLayout {
    struct LayoutResult {
        let frames: [CGRect]
        let totalSize: CGSize
    }
    
    private func calculateLayout(
        in maxWidth: CGFloat,
        subviews: Subviews
    ) -> LayoutResult {
        
        var frames: [CGRect] = []
        
        // 현재 위치 추적 변수들
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var currentRowHeight: CGFloat = 0
        var maxUsedWidth: CGFloat = 0
        var isFirstInRow = true  // 현재 줄의 첫 번째 요소인지 추적
        var rowNumber = 1  // 현재 줄 번호
        
        // 각 뷰를 하나씩 배치
        for (index, subview) in subviews.enumerated() {
            let viewSize = subview.sizeThatFits(.unspecified)
            
            // 현재 줄에 공간이 부족한지 확인 (첫 번째 요소가 아닌 경우만)
            let needsNewLine = !isFirstInRow && (currentX + viewSize.width > maxWidth)
            
            if needsNewLine {
                // 다음 줄로 이동
                currentX = 0
                currentY += currentRowHeight + verticalSpacing
                currentRowHeight = 0
                isFirstInRow = true
                rowNumber += 1
            }
            
            // 현재 위치에 뷰 배치
            let frame = CGRect(
                x: currentX,
                y: currentY,
                width: viewSize.width,
                height: viewSize.height
            )
            frames.append(frame)
            
            // 다음 뷰를 위한 위치 업데이트
            currentX += viewSize.width
            if !isFirstInRow {
                currentX += horizontalSpacing
            } else {
                isFirstInRow = false
            }
            
            currentRowHeight = max(currentRowHeight, viewSize.height)
            maxUsedWidth = max(maxUsedWidth, frame.maxX)
        }
        
        // 전체 크기 계산
        let totalSize = CGSize(
            width: maxUsedWidth,
            height: currentY + currentRowHeight
        )
        
        return LayoutResult(frames: frames, totalSize: totalSize)
    }
}
