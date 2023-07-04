//
//  ProjectsViewController.swift
//  Wohhup2023
//
//  Created by William Kendrick on 4/7/23.
//

import Foundation
import SwiftUI
import UIKit

class ProjectsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PastView.isHidden = true
        OngoingView.isHidden = true
        
    }
    @IBOutlet weak var OngoingView: UIView!
    @IBOutlet weak var PastView: UIView!
 
    
    @IBAction func BackBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "backtohomesegue", sender: self)
    }
    
    @IBAction func OngoingBtnPress(_ sender: Any) {
        OngoingView.isHidden = false
        PastView.isHidden = true
    }
    
    @IBAction func PastBtnPress(_ sender: Any) {
        PastView.isHidden = false
        OngoingView.isHidden = true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backtohomesegue" {
            let destinationVC = segue.destination as? HomeViewController
            destinationVC?.modalPresentationStyle = .fullScreen
        }
    }
    
}


