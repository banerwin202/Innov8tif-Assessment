//
//  ViewController.swift
//  Innov8tif Assignment
//
//  Created by Ban Er Win on 19/01/2022.
//

import UIKit
import Alamofire

class PostViewController: UIViewController {
    
    @IBOutlet weak var TBLPost: UITableView!
    @IBOutlet weak var VIEWNoWifi: UIView!
    @IBOutlet weak var BTNRefresh: UIButton!
    
    var arrPost : [GetPostDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        TBLPost.register(nib, forCellReuseIdentifier: "PostTableViewCell")
        
        if Connectivity.isConnectedToInternet {
            TBLPost.isHidden = false
            VIEWNoWifi.isHidden = true
            getPost()
        } else {
            TBLPost.isHidden = true
            VIEWNoWifi.isHidden = false
        }
        
    }

    //API
    func getPost() {
        let url = "\(baseURL)\(postURL)"
        CircularSpinner.show()
        HTTPHelper.request(url, method: .get) { response in
            CircularSpinner.hide()
            let model = GetPostModel(JSON: response)
            
            self.arrPost = model?.responseKey ?? []
            self.TBLPost.reloadData()
            
        }
    }
    
    @IBAction func BTNRefreshTapped(_ sender: Any) {
        if Connectivity.isConnectedToInternet {
            TBLPost.isHidden = false
            VIEWNoWifi.isHidden = true
            getPost()
        } else {
            TimerCountdown.timer(time: 3, vc: self, selector: #selector(sendAlert))
            TBLPost.isHidden = true
            VIEWNoWifi.isHidden = false
        }
    }
    
    @objc func sendAlert() {
        CircularSpinner.hide()
        let alert = UIAlertController(title: "No Internet", message: "Please refresh again", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    


}

extension PostViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPost.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        
        cell.LBLTitle.text = "Title: \(arrPost[indexPath.row].title ?? "")"
        cell.LBLBody.text = arrPost[indexPath.row].body
        
        return cell
        
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let myController = storyBoard.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
        myController.postID = arrPost[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(myController, animated: true)
        
    }

    
}
