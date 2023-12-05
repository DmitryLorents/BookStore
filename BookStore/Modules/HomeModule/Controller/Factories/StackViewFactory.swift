//
//  StackViewFactory.swift
//  BookStore
//
//  Created by Максим Горячкин on 04.12.2023.
//

import UIKit.UIStackView

protocol StackViewFactoryProtocol {
    func createStackView(with title: String, subtitle: String) -> UIStackView
}

final class StackViewFactory: StackViewFactoryProtocol {
    func createStackView(with title: String, subtitle: String) -> UIStackView {
        lazy var title: UILabel = {
            let view = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
            view.text = title
            view.font = .systemFont(ofSize: 20)
            return view
        }()
        
        lazy var subtitle: UILabel = {
            let view = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
            view.text = subtitle
            view.font = .systemFont(ofSize: 14)
            return view
        }()
        
        lazy var stackView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [title, subtitle])
            view.axis = .horizontal
            view.backgroundColor = .blue
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        return stackView
    }
    
    deinit {
//        print("\(self) deinit")
    }
}
