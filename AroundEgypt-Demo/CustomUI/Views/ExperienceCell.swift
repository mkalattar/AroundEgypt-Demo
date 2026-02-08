//
//  ExperienceCellView.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import SwiftUI

struct ExperienceCell: View {
    
    @State var experience: Experience
    var onHeartAction: ((Experience) async -> Void)
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: experience.coverPhoto ?? "")) { image in
                    image
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 16) )
                } placeholder: {
                    ProgressView()
                }
                
                VStack {
                    HStack {
                        if experience.isRecommended {
                            RecommendedView()
                        }
                        Spacer()
                        Image(systemName: "info.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 9)
                    .padding(.horizontal, 10)
                    Spacer()
                    Image(.globe)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 37, height: 37)
                    
                    Spacer()
                    HStack {
                        ViewsStatus(viewsNumber: experience.viewsNo ?? 0)
                        Spacer()
                        Image(.gallery)
                            .resizable()
                            .frame(width: 20, height: 16)
                    }
                    .padding(.bottom, 9)
                    .padding(.horizontal, 10)
                }
            }
            
            HStack {
                Text(experience.title ?? "")
                    .applyFontStyle(size: 14, fontType: .gothamBold)
                Spacer()
                HStack {
                    Text("\(experience.likesNo ?? 0)")
                        .applyFontStyle(size: 14, fontType: .gothamMed)
                    Button {
                        if experience.isLiked { return }
                        
                        experience.isLiked = true
                        
                        Task { await onHeartAction(experience) }
                    } label: {
                        Image(systemName: experience.isLiked ? "suit.heart.fill" : "suit.heart")
                            .resizable()
                            .frame(width: 20, height: 18)
                            .foregroundStyle(Color(.orange) )
                    }
                }
            }
            .padding(.top, 4)
        }
    }
}

#Preview {
    ExperienceCell(experience: Experience(id: "1", title: "Pyramids", coverPhoto: "https://assets.newatlas.com/dims4/default/17b27a2/2147483647/strip/true/crop/3017x2011+279+0/resize/1200x800!/format/webp/quality/90/?url=https%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2F33%2F8f%2F4fcb70b045219adb1c0338de5968%2Fdepositphotos-429681190-xl.png", description: "Desc", likesNo: 90, viewsNo: 90, recommended: 0, tourHtml: "", isLiked: true), onHeartAction: {_ in})
        .frame(width: 339, height: 170)

}
