//
//  ResultsViewController.swift
//  RainbowApp
//
//  Created by Nikita Savchik on 15/11/2023.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    
    //MARK: - Private Parameters
    
    private let categoriesView = CategoriesView()
    private let data = CategoriesModel.data
    private var books: [Book] = []
    private let networking: NetworkManagerProtocol = NetworkManager.shared
    private var categoryName: String = ""
    
    
    //MARK: - Life cycle
    
//    init(networking: NetworkManagerProtocol = NetworkManager.shared) {
//        self.networking = networking
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = categoriesView
        categoriesView.transferDelegates(dataSource: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoriesView.setupCollectionLayout(layout: createLayoutForCollection())
    }
    
    //MARK: - Private Methods
    
    private func createLayoutForCollection() -> UICollectionViewFlowLayout {

        let layout = UICollectionViewFlowLayout()
        let basicSpacing: CGFloat = 20
        let itemsPerRow: CGFloat = 2
        let paddingWidth = basicSpacing * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        layout.minimumLineSpacing = basicSpacing
        layout.minimumInteritemSpacing = basicSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: basicSpacing, bottom: 0, right: basicSpacing)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem * 0.66)
        return layout
    }
    
    func categoryCellTapped() {
        Task.detached(priority: .userInitiated) { [unowned self] in
            do {
                async let model: CategoryCollection = try networking.fetchAsyncData(from: .subject(category: categoryName.lowercased()))
                let books: [Book] = try await model.works.map(toBook(_:))
                await MainActor.run {
                    self.books = books
                    print("IGOR, ITS OK!")
                    presentCartVC(books)
                }
            } catch {
                await MainActor.run {
                    showError(error.localizedDescription)
                    print("IGOR, VSE PLOHO!")
                }
            }
        }
    }
    
    func showError(_ message: String) {
        
    }
    
    private func toBook(_ cat: Work) -> Book {
        .init(key: cat.key,
              name: cat.title,
              author: cat.authors.first?.name ?? "",
              category: categoryName,
              imageID: cat.coverId,
              rating: 4)
    }

    func presentCartVC(_ books: [Book]) {
        print(#function)
        navigationController?.pushViewController(CartViewController(books: books, titleCart: "\(categoryName) books"), animated: true)
    }

}
    //MARK: - Extencion for ViewCollection Protocols
    
    extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCustomCell.reuseID, for: indexPath) as? CategoryCustomCell else { fatalError() }
            cell.data = self.data[indexPath.item]
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            categoryName = data[indexPath.item].title
            categoryCellTapped()
            
        }
    }

