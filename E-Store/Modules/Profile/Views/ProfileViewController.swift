//
//  ProfileViewController.swift
//  E-Store
//
//  Created by Laptop MCO on 14/08/23.
//

import UIKit

protocol ProfileView: AnyObject {
    func showProfile()
    func showLogin()
}

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileContainerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var loginContainerView: UIView!
    var presenter: ProfilePresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.loadProfile()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Udin", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.presentImagePicker(.camera)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
                self.presentImagePicker(.photoLibrary)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
        
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        presenter.presentLogin()
    }
    
    func presentImagePicker(_ sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        dismiss(animated: true) {
            if let image = image{
                self.profileImageView.image = image
            }
        }
    }
}

extension ProfileViewController: ProfileView {
    func showProfile() {
        profileContainerView.isHidden = false
        loginContainerView.isHidden = true
        
        profileImageView.kf.setImage(with: URL(string: presenter.avatar))
        emailLabel.text = presenter.email
        nameLabel.text = presenter.name
    }
    func showLogin() {
        profileContainerView.isHidden = true
        loginContainerView.isHidden = false
    }
    
}
