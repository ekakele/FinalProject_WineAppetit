//
//  OnboardingView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 10.02.24.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var navigateToTabBar = false
    
    // MARK: - Body
    var body: some View {
        if viewModel.userPassedOnboarding() {
            TabBarControllerRepresentableView()
        } else {
            
            ZStack {
                Color.white.ignoresSafeArea()
                
                setupRectangleView
                informationStackView
            }
            .fullScreenCover(isPresented: $navigateToTabBar) {
                TabBarControllerRepresentableView()
            }
        }
    }
    
    // MARK: - Components
    private var informationStackView: some View {
        VStack {
            setupSkipButtonView
            OnboardingTabView(viewModel: viewModel)
            buttonsStackView
            setupProgressIndicatorView
        }
        .padding(.bottom, 30)
    }
    
    private var buttonsStackView: some View {
        HStack {
            if viewModel.currentPageIndex > 0 {
                MoveButtonView(
                    iconImage: "chevron.backward.circle") {
                        viewModel.goToPreviousPage()
                    }
            }
            
            Spacer()
            
            if viewModel.currentPageIndex == viewModel.onboardingPages.count - 1 {
                setupGetStartedButtonView
            } else {
                MoveButtonView(
                    iconImage: "chevron.forward.circle") {
                        viewModel.goToNextPage()
                    }
            }
        }
        .padding(EdgeInsets(top: 20, leading: 60, bottom: 20, trailing: 60))
    }
    
    private var setupGetStartedButtonView: some View {
        TextButtonView(
            title: "Get Started",
            fontSize: 16,
            fontWeight: .bold,
            action: {
                navigateToTabBar.toggle()
                viewModel.saveOnboardingPassStatus(value: true)
            }
        )
    }
    
    private var setupSkipButtonView: some View {
        TextButtonView(
            title: "Skip",
            fontSize: 16,
            fontWeight: .light,
            action: {
                navigateToTabBar.toggle()
                viewModel.saveOnboardingPassStatus(value: true)
            }
        ).padding(.horizontal, 30)
    }
    
    private var setupProgressIndicatorView: some View {
        ProgressIndicatorView(
            pageCount: viewModel.onboardingPages.count,
            currentIndex: viewModel.currentPageIndex
        )
    }
    
    private var setupRectangleView: some View {
        RectangleView(
            cornerRadius: 100,
            corners: [.topLeft, .bottomRight],
            backgroundColor: Constants.AppColor.shadeBackground
        )
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}
