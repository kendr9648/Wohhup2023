//
//  ViewController2.swift
//  Wohhup2023
//
//  Created by William Kendrick on 3/7/23.
//

import SwiftUI
import UIKit

class ViewController2: UIViewController {
    
    var seguePerformed = false
    
    private let imageView: UIImageView =  {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "Wohhuplogo")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5 , execute: {
            self.animate()
        } )
    }
    
    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 3
            let diffx = size - self.view.frame.size.width
            let diffy = self.view.frame.size.height - size
            
            
            self.imageView.frame = CGRect(x: -(diffx/2), y: diffy/2, width: size, height: size)
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
            
        }, completion: { done in
            if done {
                if !self.seguePerformed  {
                    
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute:{
                    self.performSegue(withIdentifier: "segue1", sender: self)
                    self.seguePerformed = true
                }) }
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1" {
            let destinationVC = segue.destination as? HomeViewController
            destinationVC?.modalPresentationStyle = .fullScreen
        }
    }
    

}
