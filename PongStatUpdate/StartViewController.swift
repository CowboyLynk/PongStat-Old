//
//  StartViewController.swift
//  PongStatUpdate
//
//  Created by Cowboy Lynk on 6/14/17.
//  Copyright © 2017 Cowboy Lynk. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    // Variables
    var numInitialCups = 15
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
    
    // Outlets
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var instructionButton: UIButton!
    @IBOutlet var instructionsView: UIView!
    
    // Actions
    @IBAction func startGameButtonPressed(_ sender: Any) {
        presentAlert()
    }
    @IBAction func instructionsButtonPressed(_ sender: Any) {
        springAnimateIn(viewToAnimate: instructionsView)
    }
    @IBAction func instructionsCloseButtonPressed(_ sender: Any) {
        animateOut(viewToAnimate: instructionsView)
    }
    
    // Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PongGameVC {
            destination.numInitialCups = self.numInitialCups
        }
    }
    func presentAlert() {
        let alertController = UIAlertController(title: "Number of cups", message: "Please enter the number of cups:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Play", style: .default) { (_) in
            let field = alertController.textFields![0]
            if field.text != "" && Int(field.text!)! > 0 {
                self.numInitialCups = Int(field.text!)!
                self.performSegue(withIdentifier: "startGame", sender: nil)
            } else {
                // user did not fill field
            }
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Num cups"
            textField.textAlignment = .center
            textField.keyboardType = UIKeyboardType.numberPad
        }
        
        alertController.addAction(confirmAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Animations
    func springAnimateIn(viewToAnimate: UIView){
        // Sets final score
        // finalScore.text = "Final Score: \(activeGame.score())"
        
        // Adds BG blur
        view.addSubview(blurEffectView)
        
        // Adds view to main screen
        self.view.addSubview(viewToAnimate)
        viewToAnimate.alpha = 0
        viewToAnimate.center = CGPoint.init(x: self.view.center.x, y: self.view.bounds.height)
        viewToAnimate.layer.shadowColor = UIColor.black.cgColor
        viewToAnimate.layer.shadowOpacity = 0.3
        viewToAnimate.layer.shadowOffset = CGSize.zero
        viewToAnimate.layer.shadowRadius = 20
        
        UIView.animate(withDuration: 0.4){
            viewToAnimate.alpha = 1
            self.blurEffectView.alpha = 1
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [] , animations: {
            viewToAnimate.center = CGPoint.init(x: self.view.center.x, y: self.view.bounds.height/2)
        }, completion: nil)
    }
    func animateOut(viewToAnimate: UIView){
        UIView.animate(withDuration: 0.3, animations: {
            self.blurEffectView.alpha = 0
            viewToAnimate.alpha = 0
            viewToAnimate.transform = CGAffineTransform.init(scaleX: 1.05, y: 1.05)
            
        }) { (sucsess:Bool) in
            viewToAnimate.removeFromSuperview()
            self.blurEffectView.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        
        // Whole screen blur view (used in many pop-ups)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        
        // Nav bar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 20))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        let image = UIImage(named: "Title")
        imageView.image = image
        navigationItem.titleView = imageView
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // Custon missed button appearance
        startGameButton.layer.shadowColor = UIColor(red:0.80, green:0.20, blue:0.10, alpha:1.0).cgColor
        startGameButton.layer.shadowOpacity = 1
        startGameButton.layer.shadowRadius = 0
        startGameButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        // Custom instruction button appearance
        instructionButton.layer.shadowColor = UIColor(red:0.50, green:0.50, blue:0.50, alpha:1.0).cgColor
        instructionButton.layer.shadowOpacity = 1
        instructionButton.layer.shadowRadius = 0
        instructionButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
