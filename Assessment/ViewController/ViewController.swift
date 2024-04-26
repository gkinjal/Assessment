//
//  ViewController.swift
//  Assessment
//
//  Created by apple on 26/04/24.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
        }
    }
    var postArray = [PostModel]()
    var currentPage = 1
       let itemsPerPage = 10 // Number of items to fetch per page
       var isLoadingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Posts"
        self.customNavigationView.backButton.isHidden = true
        getDetails(page: currentPage)
    }

    func getDetails(page: Int) {
        guard !isLoadingData else {
                  return // Prevent multiple requests while one is already in progress
              }
              isLoadingData = true
        
        PostVM.callPostWS(viewController: self, parameters: ["_page": "\(page)", "_limit": "\(itemsPerPage)"]) { response in
            self.postArray.append(contentsOf: response)
            DispatchQueue.main.async {
                self.tblView.reloadData()
                self.isLoadingData = false
            }
        }
    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.displayData(data: postArray[indexPath.row])
        cell.selectionStyle = .none
        if indexPath.row == postArray.count - 1 {
                  currentPage += 1 // Increment page number
                  getDetails(page: currentPage) // Load more data for the next page
              }
              
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        objVC.detail = postArray[indexPath.row]
        self.navigationController?.pushViewController(objVC, animated: true)
    }
    
}
