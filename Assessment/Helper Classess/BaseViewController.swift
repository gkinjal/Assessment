//
// BaseViewController.swift
//  Assessment
//
//  Created by apple on 27/04/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    let customNavigationView = NaviagtionView()
    var navtitle : String = "Assessment"
    var navigationHeightConstraint: NSLayoutConstraint!
    
    var sharedAppdelegate:AppDelegate {
        get{
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    
    private func setupNavigationBar() {
        customNavigationView.backgroundColor = .clear
       
       
        view.addSubview(customNavigationView)
        
        customNavigationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        let defaultHeight: CGFloat = 100
        let navigationHeight: CGFloat
        switch UIScreen.main.nativeBounds.height {
        case 1136, 1334, 1920, 2208:
            navigationHeight = defaultHeight
        case 2436, 2688, 2778:
            navigationHeight = defaultHeight + 20
        default:
            navigationHeight = defaultHeight
        }
        
        // Set the height constraint
        let imgNav = UIImageView(image: UIImage(named: "navback"))
        imgNav.contentMode = .scaleAspectFill
        imgNav.translatesAutoresizingMaskIntoConstraints = false
        customNavigationView.addSubview(imgNav)
        NSLayoutConstraint.activate([
            imgNav.topAnchor.constraint(equalTo: customNavigationView.topAnchor),
            imgNav.leadingAnchor.constraint(equalTo: customNavigationView.leadingAnchor),
            imgNav.trailingAnchor.constraint(equalTo: customNavigationView.trailingAnchor),
            imgNav.bottomAnchor.constraint(equalTo: customNavigationView.bottomAnchor)
                ])
        customNavigationView.sendSubviewToBack(imgNav)
        navigationHeightConstraint = customNavigationView.heightAnchor.constraint(equalToConstant: navigationHeight)
        navigationHeightConstraint.isActive = true
        customNavigationView.titleLabel.text = navtitle
        customNavigationView.tickButton.isHidden = true
        customNavigationView.languageChangeButton.isHidden = true
        customNavigationView.backButton.isHidden = false
        customNavigationView.backButton.setImage(UIImage(named: "back"), for: .normal)
        customNavigationView.backButton.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
    }
    
    @objc func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapTickButton() {}
    @objc func tapEditImageButton() {}
    
    func compareViewControllers(vc1: UIViewController, vc2: UIViewController) -> Bool {
        if type(of: vc1) != type(of: vc2) {
            return false
        } else {
            return true
        }
    }
}

extension BaseViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
