//
//  ViewController.swift
//  firebaseSortData
//
//  Created by Carlos Doki on 16/03/17.
//  Copyright © 2017 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var msgField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var msgs = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.MSGS_DB_REF.queryOrdered(byChild: "postedDate").observe(.value, with: { (snapshot) in
            self.msgs = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let postDict = snap.value as? [String: AnyObject] {
                        let message = Message(msgId: snap.key, msgData: postDict)
                        self.msgs.insert(message, at:0)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = msgs[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell {
            cell.configureCell(msg: msg)
            return cell
        } else {
            return MessageCell()
        }
    }
    
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        if let msgText = msgField.text, !msgText.isEmpty {
            let msg = [
                "text": msgText,
                "postedDate": FIRServerValue.timestamp()
                ] as [String : Any]
            let fireMsg = DataService.ds.MSGS_DB_REF.childByAutoId()
            fireMsg.setValue(msg)
            
            msgField.text = ""
            tableView.reloadData()
        }
    }
}

