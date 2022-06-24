//
//  ChatViewController.swift
//  chatbot-hc
//
//  Created by Giordano Mattiello on 03/06/22.
//

import UIKit

class ChatViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    var messages = [MessageDto]()
    fileprivate let cellId = "cellId"
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var messageInput: UITextField!
    @IBOutlet weak var sendButton: UIImageView!
    
    @IBOutlet weak var bottomConstraintForKeyboard: NSLayoutConstraint!
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let i = sender.userInfo!
        let s: TimeInterval = (i[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let k = (i[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        bottomConstraintForKeyboard.constant = k - bottomLayoutGuide.length
        UIView.animate(withDuration: s) { self.view.layoutIfNeeded() }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let s: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        bottomConstraintForKeyboard.constant = 0
        UIView.animate(withDuration: s) { self.view.layoutIfNeeded() }
    }

    @objc func clearKeyboard() {
        view.endEditing(true)
    }
    @objc func sendMessage(){
        let message = MessageDto(messageText:  messageInput.text , date: .now, response: false )
        messages.append(message)
        messageInput.text = ""
        
        tableView.reloadData()
        let indexPath:IndexPath = IndexPath(row:(messages.count - 1), section:0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        clearKeyboard()
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "background")
        
        headerView.addBottomShadow()
        bottomView.addTopShadow()
        let tapToRemoveKeyBoard = UITapGestureRecognizer(target: self, action: #selector(clearKeyboard))
        self.view.addGestureRecognizer(tapToRemoveKeyBoard)
        

        for i in 0...20{
            let message = MessageDto(messageText: "\(i) askmdoasdmasdm asi dmais mdias mdasimasmdiasm diasmdiamsd iamsdim asidmasi aksmdiasmd" , date: .now, response: i%2 == 0 )
            messages.append(message)
        }
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                    selector: #selector(keyboardWillShow),
                    name: UIResponder.keyboardWillShowNotification,
                    object: nil)
        NotificationCenter.default.addObserver(self,
              selector: #selector(keyboardWillHide),
              name: UIResponder.keyboardWillHideNotification,
              object: nil)
        sendButton.isUserInteractionEnabled = true
        sendButton.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(sendMessage)
        ))
    }
    
    override func viewDidLayoutSubviews() {
    }
}
extension ChatViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        let chatMessage = messages[indexPath.row]
        cell.chatMessage = chatMessage
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}


