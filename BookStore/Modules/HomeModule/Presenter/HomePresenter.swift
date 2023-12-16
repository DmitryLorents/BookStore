//
//  HomePresenter.swift
//  BookStore
//
//  Created by Максим Горячкин on 09.12.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchAsyncData<T: Decodable>(from: OpenLibraryEndpoints) async throws -> T
}

// MARK: - HomePresenterProtocol

protocol HomePresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidDisappear()
    func didSelectCategory(at index: Int)
    func didSelectTopBook(at index: Int)
    func didSelectRecentBook(at index: Int)
    func willDismissSearchController()
    func searchBarSearchButtonClicked(_ text: String)
    func willAppearSearchController()
}

// MARK: - HomePresenter

final class HomePresenter: HomePresenterProtocol {
    // MARK: - Properties
    private var topBooks = [Book]()
    private var recentBooks: [Book] {
        get {
            StorageManagerRealm.shared.getRecentBooks()
        }
    }
    
    private var topBooksHeader: HomeViewModel.Header {
        .init(title: "Top Books",
                  button: .init(title: "see more",
                                action: seeAllTopBooksButtonTap))
    }
    
    private var recentBooksHeader: HomeViewModel.Header {
        recentBooks.isEmpty ?
            .init(title: "No books watched yet",
                                    button: .init(title: "",
                                                  action: {})) :
            .init(title: "Recent Books",
                  button: .init(title: "see more",
                                action: seeAllRecentBooksButtonTap))
    }
    
    private let networking: NetworkManagerProtocol
    weak var view: HomeViewProtocol?
    weak var searchView: CartViewProtocol?
    
    // MARK: - Initialization
    
    init(networking: NetworkManagerProtocol = NetworkManager.shared) {
        self.networking = networking
    }
    
    // MARK: - Public methods

    func viewDidLoad() {
        
    }
    
    // MARK: - TODO
    func viewWillAppear() {
        fetchData()
    }
    
    // MARK: - TODO
    func viewDidDisappear() {
    }
    
    func didSelectCategory(at index: Int) {
    }
    
    func didSelectTopBook(at index: Int) {
        let book = topBooks[index]
        view?.presentProductVC(book)
        
    }
    
    func didSelectRecentBook(at index: Int) {
        let book = recentBooks[index]
        view?.presentProductVC(book)
    }
    
    func willDismissSearchController() {
        view?.renderNavigationItem()
    }
    
    func searchBarSearchButtonClicked(_ text: String) {
        searchView?.startAnimateIndicator()
        Task.detached(priority: .userInitiated) { [unowned self] in
            do {
                async let model: APISearchModel = try networking.fetchAsyncData(from: .search(text, limit: 20))
                let books: [Book] = try await model.docs.map(toBook(_:))
                await MainActor.run {
                    searchView?.render(books)
                }
            } catch {
                await MainActor.run {
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }
    
    func willAppearSearchController() {
        searchView?.render([])
    }
    
    // MARK: - Private methods
    
    private func seeAllTopBooksButtonTap() {
        view?.presentCartVC(topBooks, title: "Top books")
    }
    
    private func seeAllRecentBooksButtonTap() {
        view?.presentCartVC(recentBooks, title: "Recent books")
    }
    
    private func fetchData() {
        Task.detached(priority: .background) { [unowned self] in
            do {
                async let model: APISearchModel = try networking.fetchAsyncData(from: .home())
                let books: [Book] = try await model.docs.map(toBook(_:))
                self.topBooks = books
                await MainActor.run {
                    view?.render(
                        .init(topBooks: topBooks,
                              recentBooks: recentBooks,
                              topBooksHeader: topBooksHeader,
                              recentBooksHeader: recentBooksHeader)
                    )
                }
            } catch {
                await MainActor.run {
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }
    
    private func toBook(_ doc: Doc) -> Book {
        .init(
            key: doc.key,
            name: doc.title,
            author: doc.authorName.first ?? .init(),
            category: doc.subjectFacet?.first ?? .init(),
            imageID: doc.coverI,
            rating: doc.ratingsAverage
        )
    }
}
