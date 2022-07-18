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
        let message2 = MessageDto(messageText:  "Digitando... " , date: .now, response: true )
        messages.append(message2)
        let index = messages.count-1
        if let text = messageInput.text {
            ChatService.shared.getMessage(question: text ,completion: { message in
                let seconds = 0.5
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.messages[index] = message.toMessageDTO()
                    self.rollToTableEnd()
                }
            })
        }
        messageInput.text = ""
        rollToTableEnd()
        clearKeyboard()
    }
    
    func rollToTableEnd(){
        tableView.reloadData()
        let indexPath:IndexPath = IndexPath(row:(messages.count - 1), section:0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "background")
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        
        headerView.addBottomShadow()
        bottomView.addTopShadow()
        let tapToRemoveKeyBoard = UITapGestureRecognizer(target: self, action: #selector(clearKeyboard))
        self.view.addGestureRecognizer(tapToRemoveKeyBoard)
        self.messages.append(MessageDto(messageText: "Olá eu sou o marcelinho, vou te ajudar na sua vinda ao Ambulatório de Pediatria do HC. Envie sua dúvida aqui.", date: .now, response: true) )
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


