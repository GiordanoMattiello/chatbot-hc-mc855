//
//  ViewController.swift
//  chatbot-hc
//
//  Created by Giordano Mattiello on 28/05/22.
//

import UIKit

class MainViewController: UIViewController,UINavigationBarDelegate {
    
    @IBOutlet weak var startChat: UIView!
    @IBOutlet weak var startChatLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.startChat (_:)))
        self.startChat.addGestureRecognizer(gesture)
        self.startChat.layer.cornerRadius = 5;
        self.startChat.layer.masksToBounds = true;
        self.startChatLabel.text = "Iniciar Chat"
    }
    
    @objc func startChat(_ sender:UITapGestureRecognizer){
        performSegue(withIdentifier: "chat-segue", sender: nil)
        print("Start chat")
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

