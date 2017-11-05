//
//  AddGroupViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 05/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit

class AddGroupViewController: UIViewController {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var blurEffectView: UIVisualEffectView?
    let deepBlue = UIColor(hex: 0x0e1728)
    let lightBlue = UIColor(hex : 0x363D4C)
    let raGrp = RAGroup()
    var reloadTVData: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isOpaque = false
        setTheme()
        setBlur()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setTheme() {
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 7
        bgView.backgroundColor = UIColor(hex: 0xEA8C0D)
        nameTextField.borderStyle = .roundedRect
        nameTextField.backgroundColor = lightBlue
        nameTextField.textColor = .orange
        descTextView.backgroundColor = lightBlue
        descTextView.layer.cornerRadius = 5
        descTextView.textColor = .orange
        cancelBtn.setTitleColor(.gray, for: .normal)
        createBtn.setTitleColor(deepBlue, for: .normal)
    }

    @IBAction func cancelAction(_ sender: Any) {
        if let blur = blurEffectView {
            blur.alpha = 0
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createAction(_ sender: Any) {
        if nameTextField.text != "" {
            nameLabel.textColor = deepBlue
        } else {
            nameLabel.textColor = .red
            return
        }
        if descTextView.text != "" {
            descLabel.textColor = deepBlue
        } else {
            descLabel.textColor = .red
            return
        }
        firstly {
            raGrp.createGroup(groupName: nameTextField.text!, groupDescription: descTextView.text!)
            }.then { _ -> Void in
                if let reloadTVData = self.reloadTVData {
                    reloadTVData()
                }
                self.dismiss(animated: true, completion: nil)
            }.catch { _ in
                let alert = UIAlertController(title: "Creation échouée", message: "Une erreur est survenue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .destructive) { (av) in
                    self.dismiss(animated: true, completion: nil)
                })
                self.present(alert, animated: true, completion: nil)
        }
    }

    func setBlur() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = view.bounds
        blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView!.alpha = 0.3
        view.addSubview(blurEffectView!)
        view.sendSubview(toBack: blurEffectView!)
    }
}
