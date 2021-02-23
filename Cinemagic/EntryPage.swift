//
//  EntryPage.swift
//  Cinemagic
//
//  Created by Ayşe Bayık on 23.02.2021.
//

import UIKit
import Lottie

class EntryPage: UIViewController {

    @IBOutlet weak var header: UILabel!
    let animation = Animation.named("dashboard")
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.header.text = "Cinemagic"
        
        animationView.frame = CGRect(x: 57, y: 300, width: 300, height: 300)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
        view.addSubview(animationView)
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.performSegue(withIdentifier: "dashboard", sender: nil)
        }
    }
}
