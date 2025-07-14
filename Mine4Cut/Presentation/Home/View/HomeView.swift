//
//  HomeView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        // TODO: Navigation
        ScrollView(showsIndicators: false) {
            VStack(
                alignment: .leading,
                spacing: 16
            ) {
                // 추천 프레임 화면
                TodayFramesView()
                
                // 이번주 인기 프레임
                WeeklyRankingFrameView()
                
                // 지금 가장 많이 사용한 프레임은?
                TrendingFrameView()
                
                // 이 프레임 어때요?
                PersonalFrameView()
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    HomeView()
}
