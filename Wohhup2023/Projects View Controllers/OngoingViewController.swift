//
//  OngoingViewController.swift
//  Wohhup2023
//
//  Created by William Kendrick on 4/7/23.
//

import Foundation
import SwiftUI
import UIKit

class OngoingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var dynamicTextFields: [UITextField] = []
    
    func generateTextField() {
        let textField = UITextField()
        // Configure the text field as needed
        
        dynamicTextFields.append(textField)
        view.addSubview(textField)
    }
    
    @IBOutlet weak var ProjectID: UILabel!
    @IBOutlet weak var ProjectTitle: UILabel!
    @IBOutlet weak var ProjectManager: UILabel!
    
    
    var ProjectIDTextField: UITextField?
    var ProjectTitleTextField: UITextField?
    var ProjectManagerTextField: UITextField?
    var AddressTextField: UITextField?

    
    @IBAction func NewProjectBtnPress(_ sender: Any) {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        newView.backgroundColor = UIColor.white
        view.addSubview(newView)

            
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.frame = CGRect(x: 16, y: 16, width: 60, height: 40)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
        newView.addSubview(cancelButton)
       
        
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: (saveButton.titleLabel?.font.pointSize ?? 17.0))
        saveButton.backgroundColor = UIColor.blue
        saveButton.frame = CGRect(x: 175, y: 600, width: 55, height: 40)
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        newView.addSubview(saveButton)
        
        let ProjectIDTextField = UITextField(frame: CGRect(x: 20, y: 75, width: 200, height: 40))
        ProjectIDTextField.placeholder = "Project ID"
        ProjectIDTextField.borderStyle = .line
        ProjectIDTextField.layer.borderWidth = 1.0
        ProjectIDTextField.layer.borderColor = UIColor.black.cgColor
        self.ProjectIDTextField = ProjectIDTextField
        newView.addSubview(ProjectIDTextField)
            
        let ProjectTitleTextField = UITextField(frame: CGRect(x: 20, y: 175, width: 200, height: 40))
        ProjectTitleTextField.placeholder = "Project Name"
        ProjectTitleTextField.borderStyle = .line
        ProjectTitleTextField.layer.borderWidth = 1.0
        ProjectTitleTextField.layer.borderColor = UIColor.black.cgColor
        self.ProjectTitleTextField = ProjectTitleTextField
        newView.addSubview(ProjectTitleTextField)
        
        let AddressTextField = UITextField(frame: CGRect(x: 20, y: 275, width: 300, height: 40))
        AddressTextField.placeholder = "Project Address"
        AddressTextField.borderStyle = .line
        AddressTextField.layer.borderWidth = 1.0
        AddressTextField.layer.borderColor = UIColor.black.cgColor
        self.AddressTextField = AddressTextField
        newView.addSubview(AddressTextField)
        
        let ProjectManagerTextField = UITextField(frame: CGRect(x: 20, y: 375, width: 200, height: 40))
        ProjectManagerTextField.placeholder = "Project Manager"
        ProjectManagerTextField.borderStyle = .line
        ProjectManagerTextField.layer.borderWidth = 1.0
        ProjectManagerTextField.layer.borderColor = UIColor.black.cgColor
        self.ProjectManagerTextField = ProjectManagerTextField
        newView.addSubview(ProjectManagerTextField)
        
        let datePicker = UIDatePicker(frame: CGRect(x: 145, y: 475, width: 50, height: 40))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        newView.addSubview(datePicker)
        
        let dateText = UILabel(frame: CGRect(x: 20, y: 475, width: 300, height: 40))
        dateText.text = "Expected Completion Date:"
        newView.addSubview(dateText)
        
 
    }
    
    @objc func cancelButtonPressed(_ sender: UIButton) {
        sender.superview?.removeFromSuperview() // Remove the new view when cancel button is pressed
    }
    
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let selectedDate = datePicker.date
        // Handle the selected date
    }

    
    @objc func saveButtonPressed(_ sender: UIButton) {
        sender.superview?.removeFromSuperview()
        
        ProjectID.text = ProjectIDTextField?.text ?? ""
        ProjectTitle.text = ProjectTitleTextField?.text ?? ""
        ProjectManager.text = ProjectManagerTextField?.text ?? ""
        
        
    }

    
}
