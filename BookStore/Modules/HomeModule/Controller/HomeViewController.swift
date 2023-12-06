//
//  RainbowApp
//

import UIKit
import SwiftUI

final class HomeViewController: UIViewController {
    //MARK: - Parameters
    let sections = BookModel.sections
    lazy var mainCollectionView = CollectionViewFactory().createCollectionView(with: LayoutBuilder().createLayout(for: sections))
    lazy var dataSource = DataBuilder().createDataSource(for: mainCollectionView)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainCollectionView)
        setupConstraints()
        mainCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        mainCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        mainCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        DataBuilder().updateDataSource(for: dataSource, from: sections)
    }
    
    // MARK: - Methods
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

struct ListProvider: PreviewProvider {
    static var previews: some View {
        ConteinerView().ignoresSafeArea()
    }
    
    struct ConteinerView: UIViewControllerRepresentable {
        let homeVC = HomeViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            homeVC
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
