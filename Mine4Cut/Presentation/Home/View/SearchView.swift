//
//  SearchView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/20/25.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var filteredFrames: [FrameInfo] = [] // 검색 결과 저장
    @State private var isSearching = false
    @FocusState private var isTextFieldFocused: Bool
    
    let frameInfos: [FrameInfo] = FrameInfo.mockFrames
    
    // 화면에 표시할 데이터 결정: 검색 중이면 filteredFrames, 아니면 전체 데이터
    var displayFrames: [FrameInfo] {
        if searchText.isEmpty && !isSearching {
            return frameInfos
        } else {
            return filteredFrames
        }
    }
    
    var body: some View {
        List(displayFrames.indices, id: \.self) { idx in
            HStack(spacing: 12) {
                FrameImageView(
                    frame: displayFrames[idx],
                    width: 60,
                    height: 80
                )
                
                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {
                    Text(displayFrames[idx].title)
                        .font(.system(size: 16))
                    
                    Text(displayFrames[idx].creator)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 2) {
                        Image(systemName: "bookmark.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.blue)
                        
                        Text(String(displayFrames[idx].downloads))
                            .font(.system(size: 12))
                            .foregroundStyle(Color.blue)
                    }
                }
                
                Spacer()
            }
            .frame(height: 80)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 2.5, leading: 20, bottom: 2.5, trailing: 20))
        }
        .listStyle(.plain)
        .padding(.top, 8)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // 커스텀 뒤로가기 버튼
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                }
                .padding(.leading, 12)
            }
            
            // 검색창
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    
                    TextField("Search", text: $searchText)
                        .focused($isTextFieldFocused)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 14))
                        .frame(height: 30)
                        .onChange(of: searchText) { newValue in
                            performSearch()
                        }
                        .onSubmit {
                            performSearch()
                        }
                    
                    // 검색어 지우기 버튼
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                            filteredFrames = frameInfos
                            isSearching = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
            }
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
        .onAppear {
            filteredFrames = frameInfos // 초기 데이터 설정
        }
    }
    
    // TODO: 검색
    private func performSearch() {
        isSearching = true
        
        if searchText.isEmpty {
            filteredFrames = frameInfos
            isSearching = false
        } else {
            // 제목과 제작자에서 검색
            filteredFrames = frameInfos.filter { frame in
                frame.title.localizedCaseInsensitiveContains(searchText) ||
                frame.creator.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
