//
//  Utils.swift
//  PongStatUpdate
//
//  Created by Cowboy Lynk on 6/13/17.
//  Copyright © 2017 Cowboy Lynk. All rights reserved.
//

import Foundation
import UIKit

class PongGame: NSObject, NSCopying {
    var cupConfig: [[Bool]]
    var reRackConfig: [[Bool]]!
    var score: Double
    var madeCounter: Double
    var missedCounter: Int
    
    init(config: [[Bool]]){
        cupConfig = config
        madeCounter = 0
        missedCounter = 0
        score = 0
    }
    
    func getCount(array: [[Bool]]) -> Int{
        var count = 0
        for row in 0..<array.count{
            for col in 0..<array[0].count{
                if array[row][col]{
                    count += 1
                }
            }
        }
        return count
    }
    
    func updateScore(){
        if madeCounter + Double(missedCounter) > 0 {
            score = madeCounter/(madeCounter+Double(missedCounter))*100
        }
    }
    
    func calcCupsAround(cup: Cup) -> Int {
        var cupsAround = 0
        let maxIndex = cupConfig.count - 1
        let perms = [(-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0)]
        let row = cup.location.0
        let col = cup.location.1
        for perm in perms{
            if row + perm.0 <= maxIndex && row + perm.0 >= 0 {
                if col + perm.1 <= maxIndex && col + perm.1 >= 0 {
                    let check = self.cupConfig[row + perm.0][col + perm.1]
                    if check == true {
                        cupsAround += 1
                    }
                }
            }
        }
        return cupsAround
    }
    
    func cupsRemaining() -> Int{
        var count = 0
        for row in cupConfig{
            for cup in row{
                if cup{
                    count += 1
                }
            }
        }
        return count
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = PongGame(config: cupConfig)
        copy.madeCounter = self.madeCounter
        copy.missedCounter = self.missedCounter
        copy.score = self.score
        return copy
    }
}

class reRackSwitch: UIButton {
    // Variables
    var location = (Int(), Int())
    var switchState = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialize()
        
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    // All start code goes here
    func initialize(){
        self.backgroundColor = UIColor.gray
    }
    
    func isPressed(){
        self.switchState = !self.switchState
        if switchState{
            self.backgroundColor = UIColor(red:0.24, green:0.48, blue:0.35, alpha:1.0)
        }
        else {
            self.backgroundColor = UIColor.gray
        }
        
    }
    
}

class CustomNav: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor(red:0.20, green:0.41, blue:0.29, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 20))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        let image = UIImage(named: "Title")
        imageView.image = image
        navigationItem.titleView = imageView
    }
}
