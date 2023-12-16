//
//  StorageManagerRealm.swift
//  BookStore
//
//  Created by Admin on 13.12.2023.
//

import Foundation
import RealmSwift

class StorageManagerRealm{
    static let shared = StorageManagerRealm()
    
    private let realm = try! Realm()
    
    private init() {}

    func addToFavorites(_ book: Book) {
        let bookModel = transferBookToBookModel(book)
        bookModel.isFavorite = true
        if !checkDublicateBook(book, isFavorite: true) {
            try! realm.write {
                realm.add(bookModel)
            }
        }
    }
    
    func addToRecent(_ book: Book) {
        let bookModel = transferBookToBookModel(book)
        if !checkDublicateBook(book, isFavorite: false) {
            try! realm.write {
                realm.add(bookModel)
            }
        }
    }
    //TODO: - Check how filter is work
    func deleteBook(_ book: Book) { // удалении книги для сердечка на ProductVC и для CartVC
        let bookModel = transferBookToBookModel(book)
        do {
            if let bookToDelete = (realm.objects(BookModelData.self).filter("keyForServer == %@ AND isFavorite == true", bookModel.keyForServer).first) {
                    try realm.write {
                        realm.delete(bookToDelete)
                        print("Book deleted successfully")
                    }
            } else {
                print("Book not found for key \(bookModel.keyForServer)")
            }
        } catch {
            print("Error deleting book: \(error.localizedDescription)")
        }
    }
    
    func getFavoritesBooks() -> [Book] {
        let bookModels = realm.objects(BookModelData.self).filter("isFavorite == true")
        var books = [Book]()
        for bookModel in bookModels {
            let book = transferBookModelToBook(bookModel)
            books.append(book)
        }
        return books
    }
    
    func getRecentBooks() -> [Book] {
        let bookModels = realm.objects(BookModelData.self).filter("isFavorite == false")
        var books = [Book]()
        for bookModel in bookModels {
            let book = transferBookModelToBook(bookModel)
            books.append(book)
        }
        return books
    }
    
    func checkDublicateBook(_ book: Book, isFavorite: Bool) -> Bool {
        let bookModels = realm.objects(BookModelData.self)
        for bookModel in bookModels {
            if book.name == bookModel.name, bookModel.isFavorite == isFavorite {
                return true
            }
        }
        return false
    }
    
    private func transferBookToBookModel (_ book: Book) -> BookModelData   {
        let bookModel = BookModelData(key: book.key, name: book.name, author: book.author, category: book.category, imageID: book.imageID, rating: book.rating, isFavorite: false)
        return bookModel
    }
    
    private func transferBookModelToBook (_ bookModel: BookModelData) -> Book {
        let book = Book(key: bookModel.keyForServer, name: bookModel.name, author: bookModel.author, category: bookModel.category, imageID: bookModel.imageID, rating: bookModel.rating)
        return book
    }
}
