//
//  DetailVC.swift
//  Assessment
//
//  Created by apple on 27/04/24.
//

import UIKit

class DetailVC: BaseViewController {

    @IBOutlet weak var lblBody: UILabel!
    var detail : PostModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        lblBody.text = detail?.body
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
