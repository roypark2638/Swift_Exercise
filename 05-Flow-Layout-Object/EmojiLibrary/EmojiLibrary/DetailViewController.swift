////
////  DetailViewController.swift
////  EmojiLibrary
////
////  Created by Roy Park on 5/8/21.
////
//
//import UIKit
//
//class DetailViewController: UIViewController {
//    
//    var textLabel: UILabel?
//    
//    var emoji: String? {
//        didSet {
//            if let label = textLabel {
//                label.text = emoji
//            }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 80)
//        view.addSubview(label)
//        self.textLabel = label
//    }
//
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        textLabel?.center = view.center
//    }
//}
