//
//  ViewController.swift
//  TicTacToeDelux
//
//  Created by Jake Vo on 12/28/16.
//  Copyright © 2016 Jake Vo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var newGame: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    
    @IBOutlet weak var backHome: UIButton!
    
    
    @IBOutlet var total: [UIButton]!
    
    var countGlobal = 0
    var user = 1
    var gameState = [0,0,0,0,0,0,0,0,0]
    var winningSeries = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    var gameOver = false
    
    
    
    @IBAction func userMove(_ sender: AnyObject) {
        
        if gameOver == false {
                //human player
            
            if gameState[sender.tag - 1] == 0 && user == 1 {
                setImagePlayer (sender: sender)
                if !self.isGameDone(userTemp: 1) {
                    user = 2

                }
                
            }
            if user == 2 {
                self.cpuTurn ()
                if !self.isGameDone(userTemp: 2) {
                    self.user = 1
                }
            }
           
        }
    }
    
    func setImagePlayer(sender: AnyObject) {
        
            sender.setImage(UIImage(named: "cross.png"), for: [])
            gameState[sender.tag - 1] = 1

        
    }
    
    func setImageCpu (num: Int) {
        
        switch num {
        case 0:
            button0.setImage(UIImage(named: "nought.png"), for: [])
        case 1:
            button1.setImage(UIImage(named: "nought.png"), for: [])
        case 2:
            button2.setImage(UIImage(named: "nought.png"), for: [])
        case 3:
            button3.setImage(UIImage(named: "nought.png"), for: [])
        case 4:
            button4.setImage(UIImage(named: "nought.png"), for: [])
        case 5:
            button5.setImage(UIImage(named: "nought.png"), for: [])
        case 6:
            button6.setImage(UIImage(named: "nought.png"), for: [])
        case 7:
            button7.setImage(UIImage(named: "nought.png"), for: [])
        default:
            button8.setImage(UIImage(named: "nought.png"), for: [])
        }
        gameState[num] = 2
    }

    //checking if anyone win
    func isGameDone (userTemp: Int) -> Bool {
        //print ("calling isGameDone")
        var ret = false
        if userTemp == 1 {
            for index in winningSeries {
                countGlobal += 1
                
                if gameState[index[0]] == 1 && gameState[index[0]] == gameState[index[1]] && gameState[index[1]] == gameState[index[2]] {
                    //gameOver = true
                    statusLabel.text = "Cross won!"
                    gameOver = true
                    DoneGame()
                    ret = true
                    //break
                }
            }
        } else {
            //print ("cpu won")
            for index in winningSeries {
                countGlobal += 1
                
                if gameState[index[0]] == 2 && gameState[index[0]] == gameState[index[1]] && gameState[index[1]] == gameState[index[2]] {
                    //gameOver = true
                    statusLabel.text = "Nought won!"
                    gameOver = true
                    DoneGame()
                    ret = true
                    //break
                }
            }
        }
    
        
        if countGlobal == 72 {
            statusLabel.text = "No one wins!"
            countGlobal = 0
            DoneGame()
        }
        
        return ret
    }
    
    func cpuTurn() {
        var count = 0
        var signal = false
        while !signal {
            for index in winningSeries {
                //first case: cpu has 2 good moves
                if firstCase(index: index, count: count) == true {
                    //print ("in first case")
                    signal = true
                    break
                }
                count += 1
            }
            if signal == true {
                break
            } else {
                count = 0
            }
            for index in winningSeries {
                //second case: player has 2 good moves
                //print ("heading to second case")
                if secondCase(index: index, count: count) == true {
                    //print ("in second case")
                    signal = true
                    break
                }
                count += 1
            }
            if signal == true {
                break
            } else {
                count = 0
            }
            for index in winningSeries {
                //third case cpu has 1 good move
                //print ("heading to forth case")
                if fourthCase(index: index, count: count) == true {
                    //print ("in third case")
                    signal = true
                    break
                }
                count += 1
            }
            if signal == true {
                break
            } else {
                count = 0
            }
            for index in winningSeries {
                //four case: player has 1 good move
                //print ("heading to third case")
                if thirdCase(index: index, count: count) == true {
                    //print ("in third case")
                    signal = true
                    break
                }
                count += 1
            }
            if signal == true {
                break
            } else {
                count = 0
            }
            for index in winningSeries {
                //first case: cpu has 2 good moves
                //print ("heading to fifth case")
                if fifthCase(index: index, count: count) == true {
                    //print ("in fifth case")
                    signal = true
                    break
                }
                count += 1
            }
            if signal == true {
                break
            }
            break
        }
    }
    
    func fourthCase(index: [Int], count: Int) -> Bool {
        var ret = false
        if  gameState[index[0]] == 1 && gameState[index[1]] == 0 && gameState[index[2]] == 0 {
            
            
            switch count {
            case 0: setImageCpu(num: 1)
            case 1: setImageCpu(num: 4)
            case 2: setImageCpu(num: 7)
            case 3: setImageCpu(num: 3)
            case 4: setImageCpu(num: 4)
            case 5: setImageCpu(num: 5)
            case 6: setImageCpu(num: 4)
            default: setImageCpu(num:4)
            }
            
            ret = true
        } else if gameState[index[0]] == 0 && gameState[index[1]] == 1 &&     gameState[index[2]] == 0 {
            
                switch count {
                case 0: setImageCpu(num: 0)
                case 1: setImageCpu(num: 6)
                case 2: setImageCpu(num: 6)
                case 3: setImageCpu(num: 0)
                case 4: setImageCpu(num: 1)
                case 5: setImageCpu(num: 2)
                case 6: setImageCpu(num: 0)
                default: setImageCpu(num:2)
                }
            ret = true
        } else if gameState[index[0]] == 0 && gameState[index[1]] == 0 &&     gameState[index[2]] == 1 {
            
            switch count {
            case 0: setImageCpu(num: 1)
            case 1: setImageCpu(num: 4)
            case 2: setImageCpu(num: 7)
            case 3: setImageCpu(num: 3)
            case 4: setImageCpu(num: 4)
            case 5: setImageCpu(num: 5)
            case 6: setImageCpu(num: 4)
            default: setImageCpu(num: 7)
            }
            ret = true
        }
        
        return ret
}
    func fifthCase(index: [Int], count: Int) -> Bool {
        var ret = false

        //var winningSeries = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        //print ("4 case......")
        if  gameState[index[0]] == 0 && gameState[index[1]] == 0 && gameState[index[2]] == 0 {
            switch count {
            case 0: setImageCpu(num: Int(arc4random_uniform(2) + 0))
            case 1: setImageCpu(num: Int(arc4random_uniform(5) + 3))
            case 2: setImageCpu(num: Int(arc4random_uniform(8) + 6))
            case 3:
                if gameState[3] == 0 {
                    setImageCpu(num: 3)
                }
            case 4:
                if gameState[1] == 0 {
                    setImageCpu(num: 1)
                }
            case 5:
                if gameState[2] == 0 {
                    setImageCpu(num: 2)
                }
            case 6:
                if gameState[0] == 0 {
                    setImageCpu(num: 0)

                }
            default: setImageCpu(num: 6)
            }
            ret = true
        }
        return ret
    }

    func firstCase (index: [Int], count: Int) -> Bool {
        
        var ret = false
        if  (gameState[index[0]] == gameState[index[1]] && gameState[index[0]] == 2 && gameState[index[2]] == 0) {
            
            
            switch count {
            case 0: setImageCpu(num: 2)
            case 1: setImageCpu(num: 5)
            case 2: setImageCpu(num: 8)
            case 3: setImageCpu(num: 6)
            case 4: setImageCpu(num: 7)
            case 5: setImageCpu(num: 8)
            case 6: setImageCpu(num: 8)
            default: setImageCpu(num: 6)
            }
            ret = true
        } else if  (gameState[index[1]] == gameState[index[2]] && gameState[index[1]] == 2 && gameState[index[0]] == 0) {
            
            
            switch count {
            case 0: setImageCpu(num: 0)
            case 1: setImageCpu(num: 3)
            case 2: setImageCpu(num: 6)
            case 3: setImageCpu(num: 0)
            case 4: setImageCpu(num: 1)
            case 5: setImageCpu(num: 2)
            case 6: setImageCpu(num: 0)
            default: setImageCpu(num:2)
            }
            ret = true
            
        } else if (gameState[index[0]] == gameState[index[2]] && gameState[index[0]] == 2 && gameState[index[1]] == 0) {
            
            
            switch count {
            case 0: setImageCpu(num: 1)
            case 1: setImageCpu(num: 4)
            case 2: setImageCpu(num: 7)
            case 3: setImageCpu(num: 3)
            case 4: setImageCpu(num: 4)
            case 5: setImageCpu(num: 5)
            case 6: setImageCpu(num: 4)
            default: setImageCpu(num:4)
            }
            ret = true
        }

        return ret
    }
    
    func secondCase(index: [Int], count: Int) -> Bool {
        
        var ret = false
       
        if  (gameState[index[0]] == gameState[index[1]] && gameState[index[1]] == 1) && gameState[index[2]] == 0 {
           
            switch count {
            case 0: setImageCpu(num: 2)
            case 1: setImageCpu(num: 5)
            case 2: setImageCpu(num: 8)
            case 3: setImageCpu(num: 6)
            case 4: setImageCpu(num: 7)
            case 5: setImageCpu(num: 8)
            case 6: setImageCpu(num: 8)
            default: setImageCpu(num: 6)
            
            }
            ret = true
            //var winningSeries = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

        } else if  (gameState[index[1]] == gameState[index[2]] && gameState[index[1]] == 1 && gameState[index[0]] == 0) {
            
            
            switch count {
            case 0: setImageCpu(num: 0)
            case 1: setImageCpu(num: 3)
            case 2: setImageCpu(num: 6)
            case 3: setImageCpu(num: 0)
            case 4: setImageCpu(num: 1)
            case 5: setImageCpu(num: 2)
            case 6: setImageCpu(num: 0)
            default: setImageCpu(num:2)
            }
            ret = true
            
        } else if (gameState[index[0]] == gameState[index[2]] && gameState[index[0]] == 1 && gameState[index[1]] == 0) {
            
            
            for x in gameState {
                print (gameState[x])
            }
            switch count {
            case 0: setImageCpu(num: 1)
            case 1: setImageCpu(num: 4)
            case 2: setImageCpu(num: 7)
            case 3: setImageCpu(num: 3)
            case 4: setImageCpu(num: 4)
            case 5: setImageCpu(num: 5)
            case 6: setImageCpu(num: 4)
            default: setImageCpu(num:4)
            }
            ret = true
        }
        return ret
    }
    
    func thirdCase(index: [Int], count: Int) -> Bool  {
        var ret = false
        
        //var winningSeries = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        if  (gameState[index[0]] == 0 && gameState[index[1]] == 0 && gameState[index[2]] == 2) {
            
            //gameState[index[2]] = 2
            switch count {
            case 0: setImageCpu(num: Int(arc4random_uniform(1) + 0))
            case 1: setImageCpu(num: Int(arc4random_uniform(1) + 3))
            case 2: setImageCpu(num: Int(arc4random_uniform(1) + 6))
            case 3: setImageCpu(num: 3)
            case 4: setImageCpu(num: 4)
            case 5: setImageCpu(num: 2)
            case 6: setImageCpu(num: 4)
            default: setImageCpu(num: 2)
            
            }
            ret = true
        } else if (gameState[index[0]] == 0 && gameState[index[1]] == 2 && gameState[index[2]] == 0) {
            
            //gameState[index[2]] = 2
            switch count {
            case 0: setImageCpu(num: 0)
            case 1: setImageCpu(num: 5)
            case 2: setImageCpu(num: 6)
            case 3: setImageCpu(num: 6)
            case 4: setImageCpu(num: 1)
            case 5: setImageCpu(num: 8)
            case 6: setImageCpu(num: 0)
            default: setImageCpu(num: 6)
            }
            ret = true
        } else if (gameState[index[0]] == 2 && gameState[index[1]] == 0 && gameState[index[2]] == 0){
            
            //var winningSeries = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
            
            //gameState[index[2]] = 2
            switch count {
            case 0: setImageCpu(num: 1)
            case 1: setImageCpu(num: 5)
            case 2: setImageCpu(num: 7)
            case 3: setImageCpu(num: 6)
            case 4: setImageCpu(num: 4)
            case 5: setImageCpu(num: 8)
            case 6: setImageCpu(num: 4)
            default: setImageCpu(num: 6)
            }
            ret = true
        }
        

        
        
        return ret
    }
    /*
             print (count)
            if count == 72 {
                statusLabel.text = "What a game!"
                count = 0
                DoneGame()
                break
            }
        }
     }

 
     */
    
    
    
    func DoneGame () {
        
        self.newGame.isHidden = false
        self.backHome.isHidden = false
        self.statusLabel.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            
            self.newGame.center = CGPoint(x: self.newGame.center.x + 500, y: self.newGame.center.y)
            self.statusLabel.center = CGPoint(x: self.statusLabel.center.x - 500,y: self.statusLabel.center.y)
            //self.newButton.center = CGPoint(x: self.newButton.center.x + 500, y: self.newButton.center.y )
            
            //self.backButton.center = CGPoint(x: self.backButton.center.x + 500, y: self.backButton.center.y)
            self.backHome.center = CGPoint(x: self.backHome.center.x + 500, y: self.backHome.center.y)
            
        })
    }
    
    
    @IBAction func resetGame(_ sender: Any) {
        
        gameOver = false
        gameState = [0,0,0,0,0,0,0,0,0]
        user = 1
        for i in 1..<10 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
            newGame.isHidden = true
            statusLabel.isHidden = true
            backHome.isHidden = true
            
            countGlobal = 0
            
            newGame.center = CGPoint(x: newGame.center.x - 500, y: newGame.center.y)
            statusLabel.center = CGPoint(x: statusLabel.center.x + 500,y: statusLabel.center.y)
            backHome.center = CGPoint(x: self.backHome.center.x - 500, y: self.backHome.center.y)
            
        }
        
    }
    
    //@IBOutlet weak var newButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame.isHidden = true
        statusLabel.isHidden = true
        backHome.isHidden = true
        newGame.center = CGPoint(x: newGame.center.x - 500, y: newGame.center.y)
        statusLabel.center = CGPoint(x: statusLabel.center.x + 500,y: statusLabel.center.y)
        backHome.center = CGPoint(x: backHome.center.x - 500, y: backHome.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

