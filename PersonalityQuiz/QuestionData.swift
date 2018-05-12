//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by john goure on 5/11/18.
//  Copyright © 2018 john goure. All rights reserved.
//

import Foundation

class Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
    
    init(_ text: String, _ type: ResponseType, _ answers: [Answer]) {
        self.text = text
        self.type = type
        self.answers = answers
    }
}

class Answer {
    var text: String
    var type: Country
    
    init(_ text: String, _ type: Country) {
        self.text = text
        self.type = type
    }
}

enum ResponseType {
    case single, multiple, ranged, yesNo
}

enum Country: Character {
    case russia = "🇷🇺", usa = "🇺🇸", china = "🇨🇳", northkorea = "🇰🇵"
    
    var definition: String {
        switch self {
        case .china:
            return "You are proud and you love your people."
        case .northkorea:
            return "You are strong and weary. You can weather many storms."
        case .russia:
            return "You are strong and rely on a strong centralized coalition."
        case .usa:
            return "You are strong when you have many people standing behind you. You love your fellow man."
        }
    }
}
