//
//  DetailUserViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 08/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit
import SwiftyJSON
import Starscream

class DetailUserViewController: BaseViewController {
    struct Message {
        var message: String = ""
        var sender: String = ""
        var id: Int = 0

        init(msg: String, sender: String) {
            self.message = msg
            self.sender = sender
        }

        init(msg: String, sender: String, id: Int) {
            self.message = msg
            self.sender = sender
            self.id = id
        }
    }

    enum FriendStatus: String {
        case notFriend = "Ajouter"
        case pending = "Pending"
        case friend = "Friend"
        case unknow = " "

        var text: String {
            return self.rawValue
        }

        var image: UIImage {
            switch self {
            case .notFriend:
                return UIImage(named: "addFriend")!
            case .pending:
                return UIImage(named: "pending")!
            case .friend:
                return UIImage(named: "friend")!
            default:
                return UIImage()
            }
        }
    }
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var pseudoLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var profilePict: UIImageView!
    @IBOutlet weak var friendshipView: UIView!
    @IBOutlet weak var friendshipBtn: UIButton!
    @IBOutlet weak var friendshipImg: UIImageView!
    @IBOutlet weak var friendshipLabel: UILabel!
    @IBOutlet weak var trophyView: UIView!
    @IBOutlet weak var trophyLabel: UILabel!
    @IBOutlet weak var messagerieTV: UITableView!
    @IBOutlet weak var messagerieInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messagerieBgView: UIView!
    
    var user : User!
    var friendship: FriendStatus! {
        didSet {
            friendshipImg.image = friendship.image
            friendshipLabel.text = friendship.text
            if friendship == .friend {
                messagerieBgView.isHidden = false
                setUpWebSocket()
            }
        }
    }
    let invitManager = RAInvitations()
    let friendManager = RAFriends()

    // Messagerie
    var messages = [Message]()

    func setFakeMessages() {
        messages = [
            Message(msg: "Message 1Message 1Message 1Message 1Message 1Message 1Message 1Message 1Message 1Message 1Message 1Message 1", sender: "sender1"),
            Message(msg: "Message 2", sender: "sender2"),
            Message(msg: "Message 3", sender: "sender3"),
            Message(msg: "Message 4", sender: "sender4"),
            Message(msg: "Message 5", sender: "sender5")
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        hideKeyboardWhenTappedAround()
        friendship = .unknow
        checkFriendshipStatus()
//        setFakeMessages()
        setView()
    }

    func setView() {
        topView.layer.cornerRadius = 5
        friendshipView.layer.cornerRadius = 5
        trophyView.layer.cornerRadius = 5
        messagerieBgView.layer.cornerRadius = 5
        trophyLabel.text = "\(user.achievementPoints) points"
        pseudoLabel.text = user.nickname
        firstnameLabel.text = user.firstName
        lastnameLabel.text = user.lastName
        profilePict.translatesAutoresizingMaskIntoConstraints = false
        profilePict.roundImage(withBorder: true, borderColor: UIColor(hex: 0x0e1728), borderSize: 1.0)
        CloudinaryManager.shared.downloadProfilePicture(withUserId: String(user.id)) { (img) in
            DispatchQueue.main.async {
                self.profilePict.image = img
            }
        }
        messagerieTV.rowHeight = UITableViewAutomaticDimension
        messagerieTV.estimatedRowHeight = 140
        messagerieTV.backgroundColor = .clear
        messagerieTV.delegate = self
        messagerieTV.dataSource = self
        messagerieTV.separatorColor = .clear
        messagerieTV.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "messageCell")
        messagerieInput.addTarget(self, action: #selector(sendMessage), for: UIControlEvents.editingDidEndOnExit)
        messagerieInput.delegate = self
        messagerieInput.autocorrectionType = .no
        messagerieBgView.isHidden = true
    }

    func reloadMessagerie() {
        messagerieTV.reloadData()
        scrollToLastRow()
    }

    @objc func sendMessage() {
        if let message = messagerieInput.text, message != "" {
            let newMessage = Message(msg: message, sender: "moi")
            messages.append(newMessage)
            messagerieInput.text = ""
            reloadMessagerie()
            sendMessageWs(message: message)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = []
    }

    func checkFriendshipStatus() {
        firstly {
            friendManager.getUserFriendsList(userId: String(UserManager.instance.retrieveUserId()))
            }.then { result -> Void in
                if (result.friends.filter {$0.id == self.user.id}).count > 0 {
                    self.friendship = .friend
                } else {
                    self.friendship = .notFriend
                }
        }
    }

    @IBAction func friendshipCliqued(_ sender: Any) {
        switch friendship {
        case .notFriend:
            addFriend()
        default:
            return
        }
    }

    func addFriend() {
        friendship = .pending
        invitManager.inviteFriend(userId: String(UserManager.instance.retrieveUserId()),
                                  friendId: String(user.id)) { result in
                                    switch result {
                                    case .success:
                                        break
                                    default:
                                        self.friendship = .notFriend
                                    }
        }
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

    func setUpWebSocket() {
        var json = [String:Any]()
        json["name"] = "get_last_messages"
        var body = [String:Any]()
        body["recipient"] = user.id
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

    func sendMessageWs(message: String) {
        var json = [String:Any]()
        json["name"] = "new_message"
        var body = [String:Any]()
        body["to"] = user.id
        body["from"] = UserManager.instance.retrieveUserId()
        body["message"] = message
        json["body"] = body
        if let str = jsonToString(json: json as AnyObject) {
            ws.write(string: str)
        }
//        setUpWebSocket()
    }

    override func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("websocketDidReceiveMessage - Triggered")
        print(text)
        let json = JSON(parseJSON: text).dictionary
        if let dico = json, let name = dico["name"]?.string, name == "message_received" {
            if let body = dico["body"]?.dictionary,
                let msg = body["message"]?.string,
                let id = body["userID"]?.int,
                let sender = body["userName"]?.string,
                id == user.id {
                let newMessage = Message(msg: msg, sender: sender)
                messages.append(newMessage)
                reloadMessagerie()
                return
            }
        } else if let dico = json, let msgArray = dico["messages"]?.array {
            let newMsg: [Message] = msgArray.flatMap {elem in
                if let msg = elem["message"].string,
                    let id = elem["id"].int {
                    return Message(msg: msg, sender: self.user.nickname, id: id)
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

    override func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    }
}

extension DetailUserViewController: UITableViewDelegate, UITableViewDataSource {
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
}

extension DetailUserViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollToLastRow()
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.becomeFirstResponder()
    }
}
