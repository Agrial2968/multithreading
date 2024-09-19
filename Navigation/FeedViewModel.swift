//
//  FeedViewModel.swift
//  Navigation
//
//  Created by user on 19.09.2024.
//

import UIKit

class FeedViewModel {
    
    struct ButtonStyle {
        var title: String
        var color: UIColor
        var titleColor: UIColor
    }
    
    var checkButtonStyle: ButtonStyle
    
    var postButtonStyles: [ButtonStyle]
    
    var secretWord: String
    
    
    init(checkButtonStyle: ButtonStyle, postButtonStyles: [ButtonStyle], secretWord: String) {
        self.checkButtonStyle = checkButtonStyle
        self.postButtonStyles = postButtonStyles
        self.secretWord = secretWord
    }
}
