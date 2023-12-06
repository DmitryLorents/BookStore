//
//  HomeViewController.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit
import SwiftUI

final class HomeViewController: UIViewController {
    
    // MARK: - Parameters
    
    var sections: [BookSection]
    
    // MARK: - Initialization
    
    init(sections: [BookSection]) {
        self.sections = sections
        super.init(nibName: nil, bundle: nil)
        self.view = HomeView(sections: sections)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

struct ListProvider: PreviewProvider {
    static var previews: some View {
        ConteinerView().ignoresSafeArea()
    }
    
    struct ConteinerView: UIViewControllerRepresentable {
        let homeVC = HomeViewController(sections: BookModel.sections)
        
        func makeUIViewController(context: Context) -> some UIViewController {
            homeVC
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
