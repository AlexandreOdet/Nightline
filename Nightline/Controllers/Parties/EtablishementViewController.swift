//
//  EtablishementViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import PromiseKit
import Lightbox

class EtablishmentViewController: ProfileViewController {
    var isLiked = false
    private let animation = Animation()
    let camButton = UIButton()
    var idBar: Int!
    var restApiEtablissements = RAEtablissement()
    var images: [UIImage] = []
    let mediaBook : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    let imagePicker = UIImagePickerController()


    let cellId = "ImageCell"

    deinit {
        restApiEtablissements.cancelRequest()
    }

    override func viewDidLoad() {
        isUser = false
        super.viewDidLoad()
        setUpView()
        fetchData()
        images = MediaManager.instance.getImagesOfBar(bar_id: String(idBar))
        setupMediaBook()
    }

    override func viewWillAppear(_ animated: Bool) {
        images = MediaManager.instance.getImagesOfBar(bar_id: String(idBar))
        mediaBook.reloadData()
    }

    @objc func showParty() {
        let nextVC = DetailPartyViewController()
        nextVC.bar_id = String(idBar)
        navigationController?.pushViewController(nextVC, animated: true)
    }

    func setupMediaBook() {
        mediaBook.backgroundColor = .white
        view.addSubview(mediaBook)
        mediaBook.snp.makeConstraints { (make) in
            //      make.bottom.equalTo(self.camButton.snp.top).offset(-30)
            make.top.equalTo(self.separatorView).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
        mediaBook.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        mediaBook.dataSource = self
        mediaBook.delegate = self
        // LoadListOfImages()
    }

    // CollectionView functions:

    //  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //    return self.images.count
    //  }

    // End collectionview functions

    private func setUpView() {
        imgHeader.image = R.image.bar()
        imgProfile.image = R.image.test_logo()
        likeButton.image = (!isLiked) ? R.image.heart() : R.image.heart_filled()
        likeButton.isUserInteractionEnabled = true

        let likeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeButtonTarget))
        likeTapGestureRecognizer.numberOfTapsRequired = 1
        likeButton.addGestureRecognizer(likeTapGestureRecognizer)

        typeLabel.text = Etablishment.bar.toString()
        locationLabel.text = "Paris"
        descriptionLabel.text = ""

        let imgMenu = R.image.menu()
        img.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(10)
        }
        let button1 = UIBarButtonItem(image: imgMenu, style: .plain, target: self,
                                      action: #selector(displayEtablishmentMenuViewController))
        navigationItem.rightBarButtonItem  = button1

        view.addSubview(camButton)
        camButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(70)
        }
        let buttonImage = UIImage(named: "partyIcon")
        camButton.setImage(buttonImage, for: .normal)
        camButton.addTarget(self, action: #selector(showParty), for: .touchUpInside)
    }

    @objc func likeButtonTarget() {
        isLiked = !isLiked
        likeButton.image = (!isLiked) ? R.image.heart() : R.image.heart_filled()
        animation.bounceEffect(sender: likeButton)
    }

    @objc func displayEtablishmentMenuViewController() {
        if let nav = self.navigationController {
            let nextViewController = EtablishmentMenuViewController()
            nextViewController.bar_id = String(idBar)
            nav.pushViewController(nextViewController, animated: true)
        }
    }

    func fetchData() {
        firstly {
            restApiEtablissements.getEtablishmentProfile(idEtablishment: self.idBar)
            }.then { [weak self] resp -> Void in
              if let etabl = resp.establishment, let strongSelf = self {
                    strongSelf.nameLabel.text = etabl.name.uppercased()
                }
            }.catch { _ in
                AlertUtils.networkErrorAlert(from: self)
        }
    }
}

extension EtablishmentViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = UIColor.clear
            cell.layer.cornerRadius = 12
            cell.clipsToBounds = true
            let img = UIImageView()
            img.image = UIImage(named: "newPhotoIconWp")
            cell.addSubview(img)
            img.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.layer.cornerRadius = 12
            cell.clipsToBounds = true
            cell.backgroundColor = .clear
            let img = UIImageView()
            img.image = images[indexPath.row]
            img.contentMode = .scaleAspectFill
            cell.addSubview(img)
            img.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            return cell
        }

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            takePicture()
        default:
            let diapo = images.map {LightboxImage(image: $0)}
            let diapoController = LightboxController(images: diapo, startIndex: indexPath.row)
            diapoController.dynamicBackground = true
            present(diapoController, animated: true, completion: nil)
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return images.count
        }
    }
}

extension EtablishmentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mediaBook.frame.height, height: mediaBook.frame.height)
    }
}

extension EtablishmentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func photoFromLibrairy() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            let needAuthorization = UIAlertController(title: "Impossible", message: "Veuillez autoriser l'application a acceder a votre bibliotheque photo dans les reglages de l'appareil", preferredStyle: .alert)
            present(needAuthorization, animated: true, completion: nil)
        }
    }

    func photoFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            imagePicker.delegate = self
            present(imagePicker,animated: true,completion: nil)
        } else {
            let needAuthorization = UIAlertController(title: "Impossible", message: "Veuillez autoriser l'application a acceder a votre bibliotheque photo dans les reglages de l'appareil", preferredStyle: .alert)
            present(needAuthorization, animated: true, completion: nil)
        }

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            MediaManager.instance.saveImage(bar_id: String(idBar), image: selectedImage)
            mediaBook.reloadData()
        }
        mediaBook.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func takePicture() {
        let chooseSource = UIAlertController(title: "Choix de la source", message: "?", preferredStyle: .actionSheet)
        let roll = UIAlertAction(title: "Bibliothèque", style: .default, handler: {
            [unowned self] action in
            self.photoFromLibrairy()
        })
        let camera = UIAlertAction(title: "Camera", style: .default, handler: {
            [unowned self] action in
            self.photoFromCamera()
        })
        chooseSource.addAction(roll)
        chooseSource.addAction(camera)
        present(chooseSource, animated: true, completion: nil)
    }
}









