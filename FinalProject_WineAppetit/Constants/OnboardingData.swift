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
            description: "Your ultimate companion for exploring and selecting the perfect wine, enhancing your experience of wine enjoyment."
        ),
        Onboarding(
            imageName: "onboardingTwo",
            title: "Discover and Search Wines",
            description: "Explore a wide range of Georgian wines, where each bottle is accompanied by detailed information that highlights the distinct characteristics of each selection."
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
            description: "Easily track the calorie content per glass, combining wine enjoyment with mindful consumption."
        ),
        Onboarding(
            imageName: "onboardingSix",
            title: "Game for Social Gatherings",
            description: "Spice up your wine gatherings with a playful combination of popular social games like 'Truth or Dare' and 'Spin the Bottle', guaranteeing a memorable experience for all."
        ),
    ]
}
