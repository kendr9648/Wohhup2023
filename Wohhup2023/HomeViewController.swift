//
//  HomeViewController.swift
//  Wohhup2023
//
//  Created by William Kendrick on 3/7/23.
//

import Foundation
import SwiftUI
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func OnBtnPress(_ sender: Any) {
        self.performSegue(withIdentifier: "segue2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue2" {
            let destinationVC = segue.destination as? ProjectsViewController
            destinationVC?.modalPresentationStyle = .fullScreen
        }
    }
}
