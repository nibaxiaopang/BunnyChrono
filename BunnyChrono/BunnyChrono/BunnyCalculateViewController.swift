//
//  CalculateVC.swift
//  BunnyChrono
//
//  Created by SHREE RAM on 24/10/24.
//

import UIKit
import AVFoundation

class BunnyCalculateViewController: UIViewController {
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnAudio: UIButton!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var txtAnimalAge: UITextField!
    @IBOutlet weak var lblAnimalName: UILabel!
    
    var animalName = ""
    var isFromAnimal = ""
    var audioPlayer: AVSpeechSynthesizer!
    
    let conversionFactors: [String: Double] = [
        "Elephant": 1.5,
        "Panda": 4.0,
        "Giraffe": 1.2,
        "Bear": 2.5,
        "Koala": 3.5,
        "Tiger": 3.8,
        "Kangaroo": 3.2,
        "Zebra": 2.0,
        "Bison": 2.5,
        "Yak": 2.0,
        "Otter": 5.0,
        "Hippopotamus": 1.8
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        lblAnimalName.text = animalName
        lblAnswer.isHidden = true
        btnAudio.isHidden = true
        btnShare.isHidden = true
        audioPlayer = AVSpeechSynthesizer()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapShare(_ sender: Any) {
        let objectsToShare = [self.lblAnswer.text]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func reset(_ sender: Any) {
        btnAudio.isHidden = true
        btnShare.isHidden = true
        lblAnswer.isHidden = true
        txtAnimalAge.text = ""
    }
    
    @IBAction func tapCalculate(_ sender: Any) {
        guard let animalAgeText = txtAnimalAge.text, let animalAge = Double(animalAgeText) else {
            lblAnswer.text = "Please enter a valid age."
            return
        }
        
        if let conversionFactor = conversionFactors[isFromAnimal] {
            let humanAge = animalAge * conversionFactor
            lblAnswer.text = "The equivalent human age is \(humanAge) years."
        } else {
            lblAnswer.text = "Conversion factor not available for this animal."
        }
        
        lblAnswer.isHidden = false
        btnAudio.isHidden = false
        btnShare.isHidden = false
        
        
    }
    
    @IBAction func playAudio(_ sender: Any) {
        guard let answerText = lblAnswer.text else { return }
        let utterance = AVSpeechUtterance(string: answerText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        audioPlayer.speak(utterance)
    }
}
