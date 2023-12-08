//
//  5ViewController.swift
//  RainbowApp
//
//  Created by Nikolay1414 on 09.11.2023.
//

import UIKit
import SnapKit

class AccountViewController: UIViewController {
    
    //MARK: - Parameters
    private let accountView = AccountView()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view = accountView
        accountView.transferDelegates(delegateTextField: self)
        setupTargetForButton()
    }
    
    //MARK: - Private Methods
    private func setupTargetForButton(){
        let tapChangeImage = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        let tapChangeTheme = UITapGestureRecognizer(target: self, action: #selector(changeTheme))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        accountView.userImage.addGestureRecognizer(tapChangeImage)
        accountView.listButton.addTarget(self, action: #selector(listTupped), for: .touchUpInside)
        accountView.switcherBlack.addGestureRecognizer(tapChangeTheme)
        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Actions
    @objc func changeProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func changeTheme() {
        print("change")
    }
    
    @objc func listTupped(){
        print("List open")
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
}

// MARK: - imagePickerController
extension AccountViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            accountView.userImage.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Text Field Delegate
extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
