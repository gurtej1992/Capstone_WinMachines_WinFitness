//
//  Constants.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Mac on 20/04/21.
//

import UIKit

class Constants: NSObject {
    static let TWITTER_API_KEY = "eGnQOofGRUXuquXmBLKF33j5C"
    static let TWITTER_API_SECRET = "RH6tn1PFjuPHNWYOHMlS5iGodiwfYU476aQHM2dk5I4EozF4jC"
    static let TWITTER_CALLBACK_URL = "https://winfitness-ec238.firebaseapp.com/__/auth/handler"
    
    static let segToLogin = "toLogin"
    static let segToSignup = "toSignup"
    static let segToHome = "toHome"
    static let segToNutrition = "toNutrition"
    static let segToCommunity = "toCommunity"
    static let segToComplete = "toComplete"
    static let segToProfile = "toProfile"
    static let segToProgress = "toProgress"
    static let segToComments = "toComments"
    
    static let HomeVC = "HomeVC"
    static let WorkoutVC = "WorkoutVC"
    static let ThemePink = UIColor(named: "ThemePink")!
    static let ThemeDarkPink = UIColor(named: "ThemeDarkPink")!
}
