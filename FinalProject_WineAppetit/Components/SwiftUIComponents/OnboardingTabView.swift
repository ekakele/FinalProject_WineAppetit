//
//  OnboardingTabView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 10.02.24.
//

import SwiftUI

struct OnboardingTabView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: OnboardingViewModel
    
    // MARK: - Body
    var body: some View {
        TabView(selection: $viewModel.currentPageIndex) {
            ForEach(viewModel.onboardingPages.indices, id: \.self) { index in
                OnboardingPageView(page: viewModel.onboardingPages[index])
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

#Preview {
    OnboardingTabView(viewModel: OnboardingViewModel())
}
