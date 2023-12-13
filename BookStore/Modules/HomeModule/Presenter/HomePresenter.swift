//
//  HomePresenter.swift
//  BookStore
//
//  Created by Максим Горячкин on 09.12.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchAsyncData(from: OpenLibraryEndpoints) async throws -> APISearchModel
}

// MARK: - HomePresenterProtocol

protocol HomePresenterProtocol {
    func viewDidLoad()
    func viewDidAppear()
    func viewDidDisappear()
    func didSelectCategory(at index: Int)
    func didSelectTopBook(at index: Int)
    func didSelectRecentBook(at index: Int)
}

// MARK: - HomePresenter

final class HomePresenter: HomePresenterProtocol {
    // MARK: - Properties
    private var topBooks = [Book]()
    private var recentBooks: [Book] {
        get {
            [Book]()
        }
        set {
            view?.render(
                .init(topBooksHeader: topBooksHeader,
                      topBooks: topBooks,
                      categories: HomeCategory.allCases,
                      recentBooksHeader: recentBooksHeader,
                      recentBooks: newValue)
            )
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
    
    // MARK: - Initialization
    
    init(networking: NetworkManagerProtocol = NetworkManager.shared) {
        self.networking = networking
    }
    
    // MARK: - Public methods

    func viewDidLoad() {
        print("Data start loaded")
    }
    
    // MARK: - TODO
    func viewDidAppear() {
        fetchData()
    }
    
    // MARK: - TODO
    func viewDidDisappear() {
        
    }
    
    func didSelectCategory(at index: Int) {
        print(topBooks[index])
    }
    
    func didSelectTopBook(at index: Int) {
        print(topBooks[index])
    }
    
    func didSelectRecentBook(at index: Int) {
        print(topBooks[index])
    }
    
    // MARK: - Private methods
    
    private func seeAllTopBooksButtonTap() {
        print("See more Top Books")
    }
    
    private func seeAllRecentBooksButtonTap() {
        print("See more Recent Books")
    }
    
    private func fetchData() {
        Task.detached(priority: .background) { [unowned self] in
            do {
                async let model: APISearchModel = try networking.fetchAsyncData(from: .home())
                let books: [Book] = try await model.docs.map(toBook(_:))
                self.topBooks = books
                await MainActor.run {
                    view?.render(
                        .init(topBooksHeader: topBooksHeader,
                              topBooks: topBooks,
                              categories: HomeCategory.allCases,
                              recentBooksHeader: recentBooksHeader,
                              recentBooks: recentBooks)
                    )
                    print(topBooksHeader.title)
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
            imageID: doc.coverI
        )
    }
}
