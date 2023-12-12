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
    
    override func viewWillAppear(_ animated: Bool) {
        uploadUserDefaults()
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
    
    private func uploadUserDefaults() {
        if let name = UserDefaults.standard.string(forKey: "nameUser") {
            accountView.nameTextField.text = name
        }
        if let imagePath = UserDefaults.standard.string(forKey: "imageUser") {
            let image = UIImage(contentsOfFile: imagePath)
            
            if image != nil {
                accountView.userImage.image = image
            }
            else{
                accountView.userImage.image = UIImage(named: "avatarAccount")
            }
        }
    }
    
    private func saveNameToUserDefaults() {
        let name = accountView.nameTextField.text
        UserDefaults.standard.set(name, forKey: "nameUser")
    }
    
    private func saveImageToUserDefaults() {
        let image = accountView.userImage.image
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let uniqueFileName = UUID().uuidString + ".png"
            let fileURL = documentsDirectory.appendingPathComponent(uniqueFileName)
            
            if let imageData = image?.pngData() {
                do {
                    try imageData.write(to: fileURL)
                    UserDefaults.standard.set(fileURL.path, forKey: "imageUser")
                } catch {
                    print("Ошибка при записи изображения в файл: \(error.localizedDescription)")
                }
            }
        }
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
        saveNameToUserDefaults()
        view.endEditing(true)
    }
    
}

// MARK: - imagePickerController
extension AccountViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            accountView.userImage.image = selectedImage
            saveImageToUserDefaults()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Text Field Delegate
extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveNameToUserDefaults()
        textField.resignFirstResponder()
        return true
    }
}
