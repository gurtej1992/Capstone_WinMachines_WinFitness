//
//  User.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Mac on 20/04/21.
//

import UIKit

struct User {
    var email : String!
    var name : String!
    var picture : String = ""
    var height : String = ""
    var weight : String = ""
    var dob :String = ""
}
struct Nutritions {
    var image :String
    var link :String
    var name : String
}
enum Meal : String{
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snacks = "Snack"
}
