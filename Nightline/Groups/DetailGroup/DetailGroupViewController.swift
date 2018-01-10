//
//  DetailGroupViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 07/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit
import SnapKit
import SwiftyJSON
import Starscream

class DetailGroupViewController: BaseViewController {
    let raGrp = RAGroup()
    let grpId = 0
    var grp: GroupResponse!
    let deepBlue = UIColor(hex: 0x0e1728)
    let lightBlue = UIColor(hex : 0x363D4C)
    var grpMembers = [User]()
    var grpMembersWithOwner = [User]()
    var owner: User?
    var grpDescription: String = ""
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var membersCV: UICollectionView!
    @IBOutlet weak var editMembersBtn: UIButton!
    @IBOutlet weak var messagerieTV: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var messagerieBgView: UIView!
    @IBOutlet weak var messagerieInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var messages = [Message]()
    
    convenience init(grp: GroupResponse) {
        self.init()
        self.grp = grp
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        log.debug(grp.id)
        log.debug(grp.name)
        log.debug("Owner : \(grp.owner.pseudo)")
        log.debug("Members :")
        grp.users?.forEach { log.debug($0.nickname) }
        setTheme()
        setData()
        setMessagerie()
    }

    func setMessagerie() {
        messagerieTV.rowHeight = UITableViewAutomaticDimension
        messagerieTV.estimatedRowHeight = 140
        messagerieTV.backgroundColor = .clear
        messagerieTV.delegate = self
        messagerieTV.dataSource = self
        messagerieTV.separatorColor = .clear
        messagerieTV.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "messageCell")
        messagerieInput.delegate = self
        messagerieInput.autocorrectionType = .no
        messagerieBgView.layer.cornerRadius = 5
    }

    func setTheme() {
        mainView.backgroundColor = deepBlue
        membersCV.backgroundColor = deepBlue
        editMembersBtn.backgroundColor = lightBlue
        editMembersBtn.layer.cornerRadius = editMembersBtn.frame.height / 2
        editMembersBtn.clipsToBounds = true
        topView.layer.cornerRadius = 5
    }

    func setData() {
        membersCV.delegate = self
        membersCV.dataSource = self
        membersCV.register(UINib(nibName: "GroupMemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "grpMember")
        nameLabel.text = grp.name
        descriptionLabel.text = self.grpDescription
        grpMembers = grp.users ?? [User]()
        grpMembersWithOwner = grp.users ?? [User]()
        getOwnerData()
        membersCV.reloadData()
    }

    func getOwnerData() {
        let instance = RAUser()
        firstly {
            instance.getUserInfos(id: String(grp.owner.id))
            }.then { result -> Void in
                self.owner = result.user
                self.grpMembersWithOwner.append(result.user)
                self.setUpWebSocket()
                DispatchQueue.main.async {
                    self.membersCV.reloadData()
                }
            }.catch { error -> Void in
                log.error("DetailGroupViewController - Error getting owner informations")
                log.error(error.localizedDescription)
        }
    }
    
    @IBAction func editMembers(_ sender: Any) {
        let nextVC = EditMembersViewController(usrList: grpMembersWithOwner, grpId: grp.id)
        nextVC.modalPresentationStyle = .overCurrentContext
        present(nextVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func keyboardWillHide(noti: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }


    @objc func keyboardWillShow(noti: Notification) {

        guard let userInfo = noti.userInfo else { return }
        guard var keyboardFrame: CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }

    override func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("websocketDidReceiveMessage - Triggered")
        print(text)
        let myId = UserManager.instance.retrieveUserId()
        let myPseudo = UserManager.instance.getUserNickname()
        let json = JSON(parseJSON: text).dictionary
        if let dico = json, let name = dico["name"]?.string, name == "group_message_received" {
            if let body = dico["body"]?.dictionary,
                let msg = body["message"]?.string,
                let id = body["userID"]?.int,
                let userName = body["userName"]?.string,
                let grpId = body["groupID"]?.int
                //                let sender = body["userName"]?.string,
            {
                let newMessage = Message(msg: msg, sender: getNameOfMember(withId: id))
                insertMessage(newMsg: newMessage)
                return
            }
        } else if let dico = json,
            let name = dico["name"]?.string,
            let msgArray = dico["messages"]?.array,
            name == "last_messages" {
            let newMsg: [Message] = msgArray.flatMap {elem in
                if let msg = elem["message"].string,
                    let from = elem["from"].int,
                    let id = elem["id"].int {
                    if from == myId {
                        return Message(msg: msg, sender: getNameOfMember(withId: id), id: id)
                    } else {
                        return Message(msg: msg, sender: "moi", id: id)
                    }

                } else {
                    return nil
                }
            }
            messages = newMsg.sorted { $0.id < $1.id }
            reloadMessagerie()
            return
        }
        super.websocketDidReceiveMessage(socket: socket, text: text)
    }
}

extension DetailGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grpMembersWithOwner.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = membersCV.dequeueReusableCell(withReuseIdentifier: "grpMember", for: indexPath) as! GroupMemberCollectionViewCell
        cell.backgroundColor = deepBlue
        cell.setData(usr: grpMembersWithOwner[indexPath.row])
        cell.setView()
        return cell
    }
}


extension DetailGroupViewController: UITableViewDelegate, UITableViewDataSource {
    // Messagerie
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = messagerieTV.dequeueReusableCell(withIdentifier: "messageCell") as? MessageTableViewCell {
            cell.setCell(msg: messages[indexPath.row].message, sender: messages[indexPath.row].sender)
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func scrollToLastRow() {
        guard messages.count > 0 else { return }
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        self.messagerieTV.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    func setUpWebSocket() {
        var json = [String:Any]()
        json["name"] = "get_last_messages"
        var body = [String:Any]()
        body["recipient"] = grp.id
        body["initiator"] = UserManager.instance.retrieveUserId()
        json["body"] = body
        if let str = jsonToString(json: json as AnyObject) {
            print("Get last msg = \(str)")
            ws.write(string: str)
        }
    }

    func jsonToString(json: AnyObject) -> String? {
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data1, encoding: String.Encoding.utf8)
            print(convertedString ?? "defaultvalue")
            return convertedString
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }

    func reloadMessagerie() {
        messagerieTV.reloadData()
        scrollToLastRow()
    }

    func insertMessage(newMsg: Message) {
        messages.append(newMsg)
        let indexPath:IndexPath = IndexPath(row:(self.messages.count - 1), section:0)
        self.messagerieTV.insertRows(at: [indexPath], with: .left)
        scrollToLastRow()
    }

    @objc func sendMessage() {
        if let message = messagerieInput.text, message != "" {
            let newMessage = Message(msg: message, sender: "moi")
            insertMessage(newMsg: newMessage)
            messagerieInput.text = ""
            messagerieInput.becomeFirstResponder()
            sendMessageWs(message: message)
        }
    }

    func sendMessageWs(message: String) {
        var json = [String:Any]()
        json["name"] = "new_message"
        var body = [String:Any]()
        body["to"] = grp.id
        body["from"] = UserManager.instance.retrieveUserId()
        body["message"] = message
        json["body"] = body
        if let str = jsonToString(json: json as AnyObject) {
            ws.write(string: str)
        }
    }

    func getNameOfMember(withId id: Int) -> String {
        let users = grpMembersWithOwner.filter {$0.id == id}
        if users.count > 0 {
            return users[0].nickname
        } else {
            return "Unknow"
        }
    }


}

extension DetailGroupViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollToLastRow()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return false
    }
}

