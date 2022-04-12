//
//  gameResult.swift
//  wordle
//
//  Created by Chu Go-Go on 2022/4/11.
//

import Foundation
//回傳結果
enum gameResult {
//    會發生的條件
    case greenEmoji, orangeEmoji, darkGrayEmoji
//    結果是String的型態
    var result: String{
//        回傳你想要的結果
        switch self {
        case .greenEmoji:
            return "🟩"
        case .orangeEmoji:
            return  "🟧"
        case .darkGrayEmoji:
            return "⬛️"
        }
    }
}
