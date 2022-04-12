//
//  gameInfo.swift
//  wordle
//
//  Created by Chu Go-Go on 2022/4/5.
//

import Foundation
//建立一個struct裝題目
struct Answer {
    let answer = [
        "anise","apple","aspic","bacon","bagel","basil",
        "beans",
        "berry",
        "bland",
        "bread",
        "broil",
        "candy",
        "cater",
        "chard",
        "chili",
        "chips",
        "cream",
        "crepe",
        "crisp",
        "crust",
        "curds",
        "curry",
        "dairy",
        "dates",
        "diner",
        "dough",
        "dried",
        "drink",
        "feast",
        "flour",
        "fried",
        "fruit",
        "grain",
        "grape",
        "gravy",
        "guava",
        "herbs",
        "honey",
        "icing",
        "jelly",
        "juice",
        "kebab",
        "knife",
        "ladle",
        "lemon",
        "liver",
        "lunch",
        "maize",
        "mango",
        "melon",
        "mints",
        "mochi",
        "munch",
        "olive",
        "onion",
        "order",
        "pasta",
        "patty",
        "peach",
        "pecan",
        "pilaf",
        "pizza",
        "plate",
        "prune",
        "punch",
        "roast",
        "salad",
        "salsa",
        "sauce",
        "seeds",
        "slice",
        "snack",
        "spicy",
        "spoon",
        "spork",
        "spuds",
        "squid",
        "steak",
        "stove",
        "straw",
        "sugar",
        "sushi",
        "sweet",
        "syrup",
        "thyme",
        "toast",
        "torte",
        "tuber",
        "wafer",
        "water",
        "wheat",
        "yeast"]
//    建立一個Func來從題庫中隨機叫出一個題目
    func answerWord()->String{
//        用亂數覺出題目
        let randomNum = Int.random(in: 0...answer.count - 1)
//        因為裡面的字是小寫的，要用uppercased()升級成大寫
        let answerWordString = answer[randomNum].uppercased()
        return answerWordString
    }
    
}
