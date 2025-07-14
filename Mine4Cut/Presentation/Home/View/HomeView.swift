//
//  HomeView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            // 추천 프레임 화면
            VStack(alignment: .leading) {
                TodayFramesView()
            }
            .frame(maxWidth: .infinity)
            
            // 이번주 인기 프레임
            VStack(alignment: .leading) {
                HStack {
                    Text("이번주 인기 프레임")
                    
                    Spacer()
                }
                
                WeeklyRankingFrameView()
            }
            .frame(maxWidth: .infinity)
            
            
            // 지금 가장 많이 사용한 프레임은?
            VStack(alignment: .leading) {
                HStack {
                    Text("지금 가장 많이 사용한 프레임은?")
                    
                    Spacer()
                }
                
                TrendingFrameView()
            }
            .frame(maxWidth: .infinity)
            
            // 이 프레임은 어때요?
            VStack(alignment: .leading) {
                HStack {
                    Text("이 프레임은 어때요?")
                    Spacer()
                }
                HStack {
                    Text("선호장르를 기반으로 추천해드려요")
                    Spacer()
                }
                
                PersonalFrameView()
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
