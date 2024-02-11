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
            TabBarRepresentableView
        } else {
            setupOnboardingView
                .fullScreenCover(isPresented: $navigateToTabBar) {
                    TabBarRepresentableView
                }
        }
    }
    
    // MARK: - Components
    private var TabBarRepresentableView: some View {
        TabBarControllerRepresentableView()
            .ignoresSafeArea()
    }
    
    private var setupOnboardingView: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            setupRectangleView
            informationStackView
        }
    }
    
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
            textColor:  Constants.AppColor.burgundy,
            fontSize: 16,
            fontWeight: .regular,
            action: {
                navigateToTabBar.toggle()
                viewModel.saveOnboardingPassStatus(value: true)
            }
        )
    }
    
    private var setupSkipButtonView: some View {
        TextButtonView(
            title: "Skip", 
            textColor: Constants.AppColor.textColor,
            fontSize: 16,
            fontWeight: .light,
            action: {
                navigateToTabBar.toggle()
                viewModel.saveOnboardingPassStatus(value: true)
            }
        )
        .padding(.trailing, 30)
        .padding(.top, 10)
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
