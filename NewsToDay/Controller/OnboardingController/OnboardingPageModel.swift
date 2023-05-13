//
//  OnboardingPageModel.swift
//  NewsToDay
//
//  Created by Марк Райтман on 11.05.2023.
//

import UIKit
    struct OnboardingPage {
        var title: String
        var description: String
        var image: UIImage!
    }
    
    struct OnboardingModel {
        let pages: [OnboardingPage] = [
            OnboardingPage(title: "First to know", description: "All news in one place, be the first to know last news", image: UIImage(named: "city_1")),
            OnboardingPage(title: "Trusted sources", description: "The news that matters, just\n what you need", image: UIImage(named: "city_2")),
            OnboardingPage(title: "Never miss important information", description: "Stay up-to-date on the most important events in real-time", image: UIImage(named: "city_3")),
            OnboardingPage(title: "Manage your life with ease", description: "You can quickly and easily find the information you need", image: UIImage(named: "city_4")),
            OnboardingPage(title: "Explore new horizons of knowledge", description: "Be always in the know about the latest trends and expand your horizons", image: UIImage(named: "city_5")),
            OnboardingPage(title: "Become worldwide", description: "News all over the world are here", image: UIImage(named: "city_6"))
        ]
    }
