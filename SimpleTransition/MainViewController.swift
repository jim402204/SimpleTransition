//
//  ViewController.swift
//  SimpleTransition
//
//  Created by 江俊瑩 on 2020/11/3.
//

import UIKit

class MainViewController: UIViewController {

    var detailVC: UIViewController = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(identifier: "DetailViewController")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func action(_ sender: Any) {
        
        let detailNVC = UINavigationController(rootViewController: detailVC)
        
        detailNVC.modalPresentationStyle = .fullScreen
        //transitioningDelegate 為VC的方法
        detailNVC.transitioningDelegate = PresentAsPushTransitionDelegate.share
        
        present(detailNVC, animated: true, completion: nil)
    }
    
    
    @IBAction func layerAction(_ sender: Any) {
        
        let detailNVC = UINavigationController(rootViewController: detailVC)
        present(detailNVC)
    }
    
    
    
    @IBAction func otherAnimateAction(_ sender: Any) {
        
        let detailNVC = UINavigationController(rootViewController: detailVC)
        
        detailNVC.modalPresentationStyle = .fullScreen
        detailNVC.transitioningDelegate = ScaleTransitionDelegate.share
        
        present(detailNVC, animated: true, completion: nil)
    }
    
}

