//
//  ViewController.swift
//  CardFlip2
//
//  Copyright © 2016 Alexis Padula. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // the Outlets
    @IBOutlet weak var flipsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var messageAreaLabel: UILabel!
    @IBOutlet weak var card1_1: UIImageView!
    @IBOutlet weak var card1_2: UIImageView!
    @IBOutlet weak var card1_3: UIImageView!
    @IBOutlet weak var card1_4: UIImageView!
    @IBOutlet weak var card2_1: UIImageView!
    @IBOutlet weak var card2_2: UIImageView!
    @IBOutlet weak var card2_3: UIImageView!
    @IBOutlet weak var card2_4: UIImageView!
    @IBOutlet weak var card3_1: UIImageView!
    @IBOutlet weak var card3_2: UIImageView!
    @IBOutlet weak var card3_3: UIImageView!
    @IBOutlet weak var card3_4: UIImageView!
    @IBOutlet weak var card4_1: UIImageView!
    @IBOutlet weak var card4_2: UIImageView!
    @IBOutlet weak var card4_3: UIImageView!
    @IBOutlet weak var card4_4: UIImageView!
    
    // create the Model
    var matchGame = MatchGame()
    
    // array of Card images
    var imageViews: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViews = [card1_1, card1_2, card1_3, card1_4,
                      card2_1, card2_2, card2_3, card2_4,
                      card3_1, card3_2, card3_3, card3_4,
                      card4_1, card4_2, card4_3, card4_4]
        
        // set the welcome message
        messageAreaLabel.text = matchGame.message
    }
    
    
    // called with player taps any card
    @IBAction func cardTap(_ sender: UITapGestureRecognizer) {
        
        // which UIImageView was tapped?
        let card = sender.view! as! UIImageView
        
        var which = -1
        
        // which card (in the array) was tapped?
        for i in 0..<imageViews.count {
            if imageViews[i] == card {
                which = i
            }
        }
        
        if (which > -1) {
            // tell the model which card to flip
            matchGame.flipCardUp(which)
            
            
            // update the UIImageViews from the Model
            // changes ghosted cards to opaque
            
            for i in 0..<imageViews.count {
                let state = matchGame.getState(i)
                if(state == 3){
                    imageViews[i].alpha = 0.5
                }
                imageViews[i].image = matchGame.getImage(i)
            }
            
            // update the Labels from the Model
            flipsLabel.text = "Flips: \(matchGame.flips)"
            scoreLabel.text = "Score: \(matchGame.score)"
            messageAreaLabel.text = matchGame.message
            
        }
    }
    
    
    // restarts game and view
    @IBAction func playAgainBtn(_ sender: UIButton) {
        matchGame = MatchGame()
        for i in 0..<imageViews.count {
            imageViews[i].image = matchGame.getImage(i)
            imageViews[i].alpha = 1
        }
        
        // update the Labels from the Model
        flipsLabel.text = "Flips: \(matchGame.flips)"
        scoreLabel.text = "Score: \(matchGame.score)"
        messageAreaLabel.text = matchGame.message
    }
}
