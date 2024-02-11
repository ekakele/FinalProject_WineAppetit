//
//  OnboardingPageView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 10.02.24.
//

import SwiftUI

struct OnboardingPageView: View {
    // MARK: - Properties
    let page: Onboarding
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 40) {
            imageView
            informationStackView
        }
        .padding(.horizontal, 40)
    }
    
    // MARK: - Components
    private var informationStackView: some View {
        VStack(alignment: .leading, spacing: 10) {
            pageTitleView
            dividerView
            pageDescriptionView
        }
    }
    
    private var pageDescriptionView: some View {
        Text(page.description)
            .font(.system(size: 15))
            .foregroundColor(Constants.AppColor.textColor)
            .lineSpacing(4)
    }
    
    private var dividerView: some View {
        Rectangle()
            .foregroundColor(Constants.AppColor.burgundy)
            .frame(width: 50, height: 3)
            .background(Color(red: 0.59, green: 0.72, blue: 0.68))
            .cornerRadius(2)
    }
    
    private var pageTitleView: some View {
        Text(page.title)
            .font(.system(size: 20, weight: .bold))
    }
    
    private var imageView: some View {
        Image(page.imageName)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: 400, alignment: .center)
    }
}

#Preview {
    OnboardingPageView(page: Onboarding(imageName: "onboardingSix", title: "Title", description: "This is description text."))
}
