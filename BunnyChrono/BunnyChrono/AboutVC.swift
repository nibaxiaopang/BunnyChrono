//
//  AboutVC.swift
//  BunnyChrono
//
//  Created by SHREE RAM on 24/10/24.
//

import UIKit
import AVFoundation

class AboutVC: UIViewController {
    
    @IBOutlet weak var txtAbout: UITextView!
    
 
    var audioPlayer: AVSpeechSynthesizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        txtAbout.text = "Animal life refers to the existence and biological processes of animals, which are multicellular organisms that exhibit mobility, responsiveness to stimuli, growth, and reproduction. Unlike plants, animals are heterotrophic, meaning they rely on consuming other organisms for sustenance. They range from microscopic creatures like insects to massive mammals like whales.\n\nAnimal life is incredibly diverse, spanning millions of species that inhabit almost every environment on Earth—land, water, and air. They play critical roles in ecosystems, contributing to food chains, biodiversity, and the balance of nature. Animals exhibit a wide range of behaviors, social structures, and survival strategies, from the migratory patterns of birds to the complex communication methods of dolphins.\n\nThroughout their lives, animals undergo various stages, including birth, growth, maturity, reproduction, and eventual death. Lifespans vary drastically between species—some insects live for just days, while certain tortoises and whales can live for more than a century. Animal life is also marked by the constant adaptation and evolution of species to survive in changing environments.\n\nHumans have had complex relationships with animals, domesticating some for companionship and work (pets and livestock), and studying others for scientific and conservation purposes. Understanding animal life helps in preserving biodiversity and maintaining ecological balance."
        
        audioPlayer = AVSpeechSynthesizer()
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func share(_ sender: Any) {
        let textToShare = txtAbout.text
        let activityViewController = UIActivityViewController(activityItems: [textToShare ?? ""], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // For iPads
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    

    
    @IBAction func playAudio(_ sender: Any) {
        guard let answerText = txtAbout.text else { return }
        let utterance = AVSpeechUtterance(string: answerText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        audioPlayer.speak(utterance)
    }
    
    
    
}
