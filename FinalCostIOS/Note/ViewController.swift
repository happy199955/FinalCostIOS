//
//  ViewController.swift
//  Note
//
//  Created by user21 on 2019/6/13.
//  Copyright © 2019 user21. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var records = [Record]()
    var Total = 0
    
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var imgLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let records = Record.readRecordFromFile(){
            self.records = records
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        records = [Record]()
        if let records = Record.readRecordFromFile(){
            self.records = records
        }
        
        Total = 0
        for record in records{
            Total += record.amount
            
        }
        
        imgImage.loadGif(name: "bt210")
        
        var cost = "總共花費"
        cost = cost+String(Total)
        cost = cost + "元"
        totalCostLabel.text = "$ " + String(Total)
        let speechUtterance = AVSpeechUtterance(string:cost)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speechUtterance)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

