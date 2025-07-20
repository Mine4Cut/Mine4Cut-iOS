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
        NavigationStack {
            VStack(spacing: 0) {
                // 커스텀 네비게이션 바
                HStack {
                    Text("Mine4Cut")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            // TODO: Search Action
                        }) {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        
                        Button(action: {
                            // TODO: Plus Action
                        }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(.white)
                
                // 메인 콘텐츠
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
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeView()
}
