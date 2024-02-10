//
//  OnboardingViewModel.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 10.02.24.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    // MARK: - Properties
    @Published var onboardingPages: [Onboarding] = OnboardingData.pages
    @Published var currentPageIndex: Int = 0
    @Published var onboardingProgress: CGFloat = 0
    
    // MARK: - Methods
    func updateProgressIndicator() {
        withAnimation {
            onboardingProgress = CGFloat(currentPageIndex + 1) / CGFloat(onboardingPages.count)
        }
    }
    
    func goToNextPage() {
        if currentPageIndex < onboardingPages.count - 1 {
            withAnimation {
                currentPageIndex += 1
            }
        }
    }
    
    func goToPreviousPage() {
        if currentPageIndex > 0 {
            withAnimation {
                currentPageIndex -= 1
            }
        }
    }
    
    func skipOnboarding() {
        currentPageIndex = onboardingPages.count - 1
    }
}
