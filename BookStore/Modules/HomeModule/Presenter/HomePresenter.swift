//
//  Presenter.swift
//  BookStore
//
//  Created by Максим Горячкин on 09.12.2023.
//

import Foundation

// MARK: - HomePresenterProtocol

protocol HomePresenterProtocol {
    var topBooks: [Book] { get }
    var recentBooks: [Book] { get }
    var view: HomeViewProtocol! { get set }
    func fetchData()
    func presentAllBooks()
}

// MARK: - HomePresenter

final class HomePresenter: HomePresenterProtocol {
    
    // MARK: - Properties
    
    var topBooks: [Book] = []
    var recentBooks: [Book] = []
    weak var view: HomeViewProtocol!
    
    // MARK: - Initialization
    
    init() {
        fetchData()
    }
    
    // MARK: - Publick methods
    
    func presentAllBooks() {
        
    }
    
    func fetchData() {
        Task.detached(priority: .background) { [unowned self] in
            do {
                let url = RequestCreator().createRequest()
                print("Data start loaded")
                let result: Result<APISearchModel, NetworkError> = try await NetworkManager.shared.fetchAsyncData(from: url)
                switch result {
                case .failure( _):
                    print("Can't parce data")
                case .success(let data):
                    self.updateTopBooks(with: data)
                    print("Data loaded")
                    await self.updateBooksCells(topBooks: self.topBooks, recentBooks: self.recentBooks)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func updateTopBooks(with data: APISearchModel) {
         let books = data.docs
        books.forEach {
            if let name = $0.title, let author = $0.authorName?.first, let category = $0.subjectFacet?.first, let imageID = $0.coverI {
                let book = Book(name: name, author: author, category: category, imageID: imageID)
                topBooks.append(book)
            }
        }
    }
    
    @MainActor
    private func updateBooksCells(topBooks: [Book], recentBooks: [Book]) {
        view.reloadData(topBooks, recentBooks)
    }
}
