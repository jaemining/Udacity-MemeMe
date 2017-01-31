//
//  TableViewController.swift
//  MemeMe
//
//  Created by LimJaemin on 2017. 1. 27..
//  Copyright © 2017년 LimJaemin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var memes: [Meme]!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memes = appDelegate.memes
        tableView.reloadData()
        
        super.viewWillAppear(animated)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell

        let meme = appDelegate.memes[indexPath.row]
        cell.tableImageView.image = meme.memedImage
        cell.tableTopTextField.text = meme.textFielTop
        cell.tableBottomTextField.text = meme.textFieldBottom
        
        cell.tag = indexPath.row
        cell.isUserInteractionEnabled = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        
        imageViewController.meme = memes[indexPath.row]
        
        present(imageViewController, animated: true, completion: nil)
    }
}
