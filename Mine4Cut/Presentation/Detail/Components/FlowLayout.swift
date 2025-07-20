//
//  FlowLayout.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/20/25.
//

import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat? = nil
    var lineSpacing: CGFloat = 8
    
    // MARK: - 각 subview의 크기, 간격 정보를 미리 계산해서 저장
    struct Cache {
        var sizes: [CGSize] = []
        var spacing: [CGFloat] = []
    }
    
    // MARK: - 레이아웃 계산 시 반복 계산 피하기 위함
    func makeCache(subviews: Subviews) -> Cache {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        // 각 subview 간의 간격 계산
        let spacing: [CGFloat] = subviews.indices.map { index in
            // 마지막 요소는 다음 요소가 없으므로 간격이 0
            guard index != subviews.count - 1 else {
                return 0
            }
            
            // 현재 요소와 다음 요소 사이의 간격 계산
            return subviews[index].spacing.distance(
                to: subviews[index+1].spacing,
                along: .horizontal
            )
        }
        
        return Cache(sizes: sizes, spacing: spacing)
    }
    
    // MARK: - 레이아웃 크기 계산
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) -> CGSize {
        var totalHeight = 0.0  // 전체 높이
        var totalWidth = 0.0   // 전체 너비
        
        var lineWidth = 0.0    // 현재 너비
        var lineHeight = 0.0   // 현재 높이
        
        // 모든 subview를 순차적으로 처리
        for index in subviews.indices {
            // 현재 요소를 추가했을 때 제안된 너비를 초과하는지 확인
            if lineWidth + cache.sizes[index].width > proposal.width ?? 0 {
                // 다음 줄로 이동
                totalHeight += lineHeight + lineSpacing
                lineWidth = cache.sizes[index].width  // 새 줄의 첫 번째 요소
                lineHeight = cache.sizes[index].height
            } else {
                // 같은 줄에 추가
                lineWidth += cache.sizes[index].width + (spacing ?? cache.spacing[index])
                lineHeight = max(lineHeight, cache.sizes[index].height)  // 줄 높이는 가장 높은 요소에 맞춤
            }
            
            // 전체 너비 업데이트 (가장 긴 줄의 너비)
            totalWidth = max(totalWidth, lineWidth)
        }
        
        // 마지막 줄의 높이 추가
        totalHeight += lineHeight
        
        return .init(width: totalWidth, height: totalHeight)
    }
    
    // MARK: - 실제 요소 배치
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) {
        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = 0
        
        for index in subviews.indices {
            // 현재 요소가 줄 너비를 초과하는지 확인
            if lineX + cache.sizes[index].width > (proposal.width ?? 0) {
                lineY += lineHeight + lineSpacing
                lineHeight = 0
                lineX = bounds.minX
            }
            
            // 요소의 중심점 계산 (anchor가 .center이므로)
            let position = CGPoint(
                x: lineX + cache.sizes[index].width / 2,
                y: lineY + cache.sizes[index].height / 2
            )
            
            // 현재 줄의 높이 업데이트
            lineHeight = max(lineHeight, cache.sizes[index].height)
            
            // 다음 요소를 위해 X 위치 이동
            lineX += cache.sizes[index].width + (spacing ?? cache.spacing[index])
            
            // 실제 subview를 계산된 위치에 배치
            subviews[index].place(
                at: position,
                anchor: .center,
                proposal: ProposedViewSize(cache.sizes[index])
            )
        }
    }
}
