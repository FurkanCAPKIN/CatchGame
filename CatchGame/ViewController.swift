import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kosArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scorelabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    //köstebek imagelerini tanımladım.
    @IBOutlet weak var kos1: UIImageView!
    @IBOutlet weak var kos2: UIImageView!
    @IBOutlet weak var kos3: UIImageView!
    @IBOutlet weak var kos4: UIImageView!
    @IBOutlet weak var kos5: UIImageView!
    @IBOutlet weak var kos6: UIImageView!
    @IBOutlet weak var kos7: UIImageView!
    @IBOutlet weak var kos8: UIImageView!
    @IBOutlet weak var kos9: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scorelabel.text="Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore :\(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "HighScore :\(highScore)"
        }
        
        
        kos1.isUserInteractionEnabled = true
        kos2.isUserInteractionEnabled = true
        kos3.isUserInteractionEnabled = true
        kos4.isUserInteractionEnabled = true
        kos5.isUserInteractionEnabled = true
        kos6.isUserInteractionEnabled = true
        kos7.isUserInteractionEnabled = true
        kos8.isUserInteractionEnabled = true
        kos9.isUserInteractionEnabled = true
        //kullanıcı resmin üzerine tıklayıp etkileşime oluşturabilir.
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        kos1.addGestureRecognizer(recognizer1)
        kos2.addGestureRecognizer(recognizer2)
        kos3.addGestureRecognizer(recognizer3)
        kos4.addGestureRecognizer(recognizer4)
        kos5.addGestureRecognizer(recognizer5)
        kos6.addGestureRecognizer(recognizer6)
        kos7.addGestureRecognizer(recognizer7)
        kos8.addGestureRecognizer(recognizer8)
        kos9.addGestureRecognizer(recognizer9)
        
        
        kosArray = [kos1, kos2, kos3, kos4, kos5, kos6, kos7, kos8, kos9]
        
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(cauntDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideKos), userInfo: nil, repeats: true)
        
        hideKos()
        
    }
    
    @objc func hideKos() {
        
        for kos in kosArray {
            kos.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kosArray.count-1)))
        kosArray[random].isHidden = false
        
    }

    @objc func increaseScore() {
        score += 1
        scorelabel.text = "Score :\(score)"
        
    }
    
    @objc func cauntDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kos in kosArray {
                kos.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Score :\(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            let alert = UIAlertController(title: "Zamanın doldu", message: "Tekrar oynamak ister misin?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { 
                (UIAlertAction) in
                self.score = 0
                self.scorelabel.text = "Score :\(self.score) "
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.cauntDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hideKos), userInfo: nil, repeats: true)
               
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }

}

