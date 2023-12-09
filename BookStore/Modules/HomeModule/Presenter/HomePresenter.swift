//
//  Presenter.swift
//  BookStore
//
//  Created by Максим Горячкин on 09.12.2023.
//

import Foundation

protocol HomePresenterProtocol {
    var topBooks: [Book] { get }
    var recentBooks: [Book] { get }
    var view: HomeViewProtocol! { get set }
    func fetchData()
    func presentAllBooks()
}

class HomePresenter: HomePresenterProtocol {
    var topBooks: [Book] = []
    var recentBooks: [Book] = []
    weak var view: HomeViewProtocol!
    
    init() {
        print("Presenter init")
        fetchData()
    }
    
    func fetchData() {
        Task.detached(priority: .userInitiated) { [unowned self] in
            do {
                let url = RequestCreator().createRequest(.home)
                print("Data start loaded")
                let result: Result<APISearchModel, NetworkError> = try await NetworkManager.shared.fetchAsyncData(from: url)
                switch result {
                case .failure( _):
                    print("Can't parce data")
                case .success(let data):
                    updateTopBooks(with: data)
                    print("Data loaded")
                    await updateTopBooks(topBooks: topBooks)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func presentAllBooks() {
        
    }
    
    private func updateTopBooks(with data: APISearchModel) {
        let books = data.docs
        books.forEach {
            if let name = $0.title, let author = $0.authorName?.first, let category = $0.subjectFacet?.first {
                let book = Book(name: name, author: author, category: category)
                print(book)
                topBooks.append(book)
            }
        }
    }
    
    @MainActor
    private func updateTopBooks(topBooks: [Book]) {
        view.updateTopBooks(topBooks)
    }
}
