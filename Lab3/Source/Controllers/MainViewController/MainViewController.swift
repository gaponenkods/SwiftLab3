//
//  MainViewController.swift
//  Lab3
//
//  Created by Konstantyn Byhkalo on 1/24/17.
//  Copyright © 2017 Gaponenko Dmitriy. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh

class MainViewController: UIViewController {
    
//    MARK: - Properties

    @IBOutlet var tableView: UITableView!
    
    var messageModels: [MessageModel] = []
    
//    MARK: - ViewController Lifa Cycle
    
    override func loadView() {
        super.loadView()
        
        configurateNavigationBar()
        configuratePullRefresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    deinit {
        tableView.dg_removePullToRefresh()
    }
    
//    MARK: - Configurate Methods
    
    func configurateNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(red: 249/255.0, green: 181/255.0, blue: 53/255.0, alpha: 1.0)
    }
    
    func configuratePullRefresh() {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.white
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            ChatManager.sharedInstanse.loadAllMessages(completionHandler: { (messagesArray) in
                self?.messageModels = messagesArray
                DispatchQueue.main.async {
                    self?.tableView.dg_stopLoading()
                    self?.tableView.reloadData()
                }  
            })}, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 249/255.0, green: 181/255.0, blue: 53/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }
    
//    MARK: - Actions
    
    @IBAction func composeButtonSelect(_ sender: UIBarButtonItem) {
        messageAlert()
    }
    
//    MARK: - Alerts
    
    func messageAlert() {
        
        let alertController = UIAlertController(title: "New message", message: "Please state your name and message", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Your name"
        } )
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Your message"
        } )
        let sendAction = UIAlertAction(title: "Send", style: .default, handler: { action in
            guard let name = alertController.textFields?[0].text,
                let message = alertController.textFields?[1].text else {
                    return
            }
            
            ChatManager.sharedInstanse.sendMessageBy(author: name, message: message, completionHandler: { (isSuccess) in
                let textInfo = isSuccess ? "Your message send successfully" : "Your message isn't send"
                self.informationAlertWith(textMessage: textInfo)
            })
        })
        alertController.addAction(sendAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in })
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: { _ in })
    }
    
    func informationAlertWith(textMessage: String) {
        let alert = UIAlertController(title: "Information", message: textMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

//    MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if let cell = cell {
            let helpMessageModel = messageModels[indexPath.row]
            return helpMessageModel.configureCell(cell: cell)
        }
        
        return UITableViewCell()
    }
    
//    MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

