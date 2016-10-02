//
//  MatchGame.swift
//  CardFlip2
//
//  Created by Joel Hollingsworth on 9/26/16.
//  Copyright © 2016 Joel Hollingsworth. All rights reserved.
//

import UIKit

/**
 * This is the Model for the Match Game.
 */
class MatchGame {
    
    let deck = Deck()
    var flips = 0
    var score = 0
    var message = "Welcome!"
    var match = false
    
    var previous = -1
    
    var matrix: [Card] = []
    
    init() {
        // draw 16 random cards
        for _ in 1...16 {
            matrix.append(deck.drawRandomCard())
        }
    }
    
    /*
     * Called when a card is tapped.
     */
    func flipCardUp(_ which: Int) {
        
        // only need to do something if card is facing down
        if matrix[which].isShowing == false {
            
            // flip up
            matrix[which].isShowing = true
            
            // update values/text
            flips += 1
            message = matrix[which].text
            
            
            if (previous != -1) {
                
                if matrix[which].suit == matrix[previous].suit{
                    matrix[which].state = .ghosted
                    matrix[previous].state = .ghosted
                    match = true
                    previous = -1
                    score += 4
                    message = "Suit Match"
                }
                else if matrix[which].value == matrix[previous].value{
                    matrix[which].state = .ghosted
                    matrix[previous].state = .ghosted
                    match = true
                    previous = -1
                    score += 16
                    message = "Value Match"
                }
               else{
                // flip over the previous card
                matrix[previous].isShowing = false
                previous = which
            }
            }
            // remember the last card tapped
            
            if(!match){
            previous = which
            score -= 1
            }
        match = false
        }
    }
    
    /*
     * Return the current image for a particular Card
     */
    func getImage(_ which: Int) -> UIImage {
        return matrix[which].getImage()
    }
    
    
}
