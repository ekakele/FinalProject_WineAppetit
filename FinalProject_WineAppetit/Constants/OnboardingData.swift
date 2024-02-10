//
//  OnboardingData.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 10.02.24.
//

import Foundation

struct OnboardingData {
    static let pages: [Onboarding] = [
        Onboarding(
            imageName: "onboardingOne",
            title: "Welcome to WineAppétit!",
            description: "Your guide to the ideal wine selection and enhanced enjoyment."
        ),
        Onboarding(
            imageName: "onboardingTwo",
            title: "Discover and Search Wines",
            description: "Explore a wide selection of Georgian wines and gain detailed insights into each distinct selection."
        ),
        Onboarding(
            imageName: "onboardingThree",
            title: "Simplified Wine Selection",
            description: "Made the wine selection process effortless and fun - with just a few taps, we pick random wines based on your preferences."
        ),
        Onboarding(
            imageName: "onboardingFour",
            title: "Build Your Wine Library",
            description: "Store your favorite wines and those you're curious to taste on your virtual shelves, building your own wine library and maintaining a personalized wine history."
        ),
        Onboarding(
            imageName: "onboardingFive",
            title: "Calorie Tracking Made Easy",
            description: "Easily track the calories per glass, combining wine enjoyment with mindful consumption."
        ),
        Onboarding(
            imageName: "onboardingSix",
            title: "Game for Social Gatherings",
            description: "Transform your wine gatherings with a digital twist on the combination of popular social games 'Truth or Dare' and 'Spin the Bottle'."
        ),
    ]
}
