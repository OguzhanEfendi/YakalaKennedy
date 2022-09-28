//
//  ViewController.swift
//  YakalaKennedyHomework
//
//  Created by oğuzhan efendioğlu on 21.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny: UIImageView!
    
    @IBOutlet weak var backLabel: UILabel!
    var timer = Timer()
    var timerImage = Timer()
    var counter = 15
    var alert = UIAlertController()
    var topObject = 0.0
    var width = 0.0
    var height = 0.0
    var scocer = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        width = view.frame.size.width
        height = view.frame.size.height
        

        
        
        
        alert = UIAlertController(title: "Oyun Bitti", message: "Süre Doldu!", preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.destructive,handler: nil)
        let newButton = UIAlertAction(title: "Yeni Oyun", style: UIAlertAction.Style.default) { UIAlertAction in
            self.counter = 7
            self.scocer = 0
            self.setUpTimer()
        }
        
        alert.addAction(okButton)
        alert.addAction(newButton)
        
        kenny.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabImage))
        kenny.addGestureRecognizer(gestureRecognizer)
        
        if let readHighScore=UserDefaults.standard.object(forKey: "highScore") {
            highScoreLabel.text = "High Score: \(readHighScore)"
        } else{
            highScoreLabel.text = "High Score: 0"
        }
        

        setUpTimer()

    }


    
    
    func setUpTimer(){
        scoreLabel.text = "Your Score : \(scocer)"
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeControl), userInfo: nil, repeats: true)
        timerImage=Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(changePosition), userInfo: nil, repeats: true)
    }
    
    @objc func tabImage(){
        scocer += 1
        scoreLabel.text = "Your Score : \(scocer)"
    }
    
    
    @objc func timeControl(){
        
        timeLabel.text="Time: \(counter)"
        counter -= 1
        
        if  counter < 0{
            timer.invalidate()
            timerImage.invalidate()
            self.present(alert, animated: true, completion: nil)
            
            if let readHighScore=UserDefaults.standard.object(forKey: "highScore") {
                if scocer > readHighScore as! Int {
                    print(readHighScore)
                    UserDefaults.standard.set(scocer, forKey: "highScore")
                    highScoreLabel.text = "High Score: \(scocer)"
                }
            } else{
                UserDefaults.standard.set(scocer, forKey: "highScore")
            }
        }
        
    }
    
    @objc func changePosition(){
        
        let randomY=(Double.random(in:  (scoreLabel.layer.position.y+scoreLabel.frame.size.height)..<((highScoreLabel.layer.position.y - kenny.frame.size.height))))
        
        let randomx=(Double.random(in:  ((0.0)..<(width-kenny.frame.size.width))))
        
        kenny.frame = CGRect(x: randomx, y: randomY, width: kenny.frame.size.width, height: kenny.frame.size.height)
    }
    
    


}

