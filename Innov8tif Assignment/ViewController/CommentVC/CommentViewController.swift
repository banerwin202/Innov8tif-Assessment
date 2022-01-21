//
//  CommentViewController.swift
//  Innov8tif Assignment
//
//  Created by Ban Er Win on 20/01/2022.
//

import UIKit

class CommentViewController: UIViewController {
    
    @IBOutlet weak var TBLComment: UITableView!
    @IBOutlet weak var VIEWNoWifi: UIView!
    
    var postID : Int = 0
    var arrComment : [GetCommentDetails] = []
    var comments = [String]()
    var filteredComments = [String]()
    
    var searchController: UISearchController!
    var isSearch: Bool?
    var isSearchTapped: Bool?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        TBLComment.register(nib, forCellReuseIdentifier: "CommentTableViewCell")
        setupViewSearch()
        if Connectivity.isConnectedToInternet {
            TBLComment.isHidden = false
            VIEWNoWifi.isHidden = true
            getComment()
        } else {
            TBLComment.isHidden = true
            VIEWNoWifi.isHidden = false
        }
       
   

    }
    
    func setupViewSearch() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Comments"
        searchController.searchBar.delegate = self

        TBLComment.tableHeaderView = searchController.searchBar
        searchController.searchBar.sizeToFit()

        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
    }
    
    //API
    func getComment() {
        let url = "\(baseURL)\(postURL)/\(postID)/\(commentURL)"
        CircularSpinner.show()
        HTTPHelper.request(url, method: .get) { response in
            CircularSpinner.hide()
            let model = GetCommentModel(JSON: response)
            self.arrComment = model?.responseKey ?? []
            
            for comment in model?.responseKey ?? [] {
                self.comments.append(comment.body ?? "")
            }
            self.filteredComments = self.comments
            self.TBLComment.reloadData()
            
            
        }
    }
    
    @IBAction func BTNRefreshTapped(_ sender: Any) {
        if Connectivity.isConnectedToInternet {
            TBLComment.isHidden = false
            VIEWNoWifi.isHidden = true
            getComment()
        } else {
            TimerCountdown.timer(time: 3, vc: self, selector: #selector(sendAlert))
            TBLComment.isHidden = true
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

extension CommentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredComments.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
         
        cell.LBLName.text = "Name: \(arrComment[indexPath.row].name ?? "")"
        cell.LBLEmail.text = "Email: \(arrComment[indexPath.row].email ?? "")"
        cell.LBLBody.text = filteredComments[indexPath.row]
        
        return cell
        
    }

    
}

extension CommentViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        isSearch = true
        TBLComment.reloadData()
        
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredComments = []
        isSearchTapped = true
        
        if searchText == "" {
            filteredComments = self.comments
        } else {
            for name in self.comments {
                if name.lowercased().contains(searchText.lowercased()) {
                    filteredComments.append(name)
                }
            }
        }
        self.TBLComment.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if filteredComments.count == 0 {
            self.filteredComments = self.comments
            
            TBLComment.reloadData()
        }
       
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if filteredComments.count == 0  {
            self.filteredComments = self.comments
            
            TBLComment.reloadData()
        }
        
    }

}
