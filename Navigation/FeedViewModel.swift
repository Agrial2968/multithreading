//
//  FeedViewModel.swift
//  Navigation
//
//  Created by user on 19.09.2024.
//

import UIKit

//Game model view + logic
class FeedViewModel {
    
    private var feedModel: FeedModel
    
    init(feedModel: FeedModel) {
        self.feedModel = feedModel
    }
    
    func check(word: String) -> UIColor {
        return self.feedModel.secretWord == word ? .green : .red
    }
}

//Game model
class FeedModel {
    var secretWord: String
    
    init(secretWord: String) {
        self.secretWord = secretWord
    }
}
