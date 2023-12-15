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
    
    func saveBook(_ book: Book) {
        let bookModel = transferBookToBookModel(book)
        if !checkDublicateBook(book) {
            try! realm.write {
                realm.add(bookModel)
            }
        }
    }
    
    func deleteBook(withBook book: Book) { // удалении книги для сердечка на ProductVC и для CartVC
        let bookModel = transferBookToBookModel(book)
        do {
            if let bookToDelete = realm.objects(BookModelData.self).filter("keyForServer == %@", bookModel.keyForServer).first {
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
    
    func getFavoritesBooks() -> [Book] { // получения всех сохранёных данных
        let bookModels = realm.objects(BookModelData.self).filter({$0.isRecent == false})
        var books = [Book]()
        for bookModel in bookModels {
            let book = transferBookModelToBook(bookModel)
            books.append(book)
        }
        return books
    }
    
    func checkDublicateBook(_ book: Book) -> Bool { // проверка дубликата для добавление в избранное
        let bookModels = realm.objects(BookModelData.self)
        for bookModel in bookModels {
            if book.name == bookModel.name {
                return true
            }
        }
        return false
    }
    
    func allDelete() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func addToRecent(_ book: Book) {
        let bookModel = transferBookToBookModel(book)
        bookModel.isRecent = true
        try! realm.write {
            realm.add(bookModel)
        }
    }
    
    func getRecentBooks() -> [Book] {
        let bookModels = realm.objects(BookModelData.self).filter({$0.isRecent==true})
        var books = [Book]()
        for bookModel in bookModels {
            let book = transferBookModelToBook(bookModel)
            books.append(book)
        }
        return books
    }
    
    func transferBookToBookModel(_ book: Book) -> BookModelData {
        let bookModel = BookModelData(key: book.key, name: book.name, author: book.author, category: book.category, imageID: book.imageID, rating: book.rating)
        return bookModel
    }
    
    func transferBookModelToBook(_ bookModel: BookModelData) -> Book {
        let book = Book(key: bookModel.keyForServer, name: bookModel.name, author: bookModel.author, category: bookModel.category, imageID: bookModel.imageID, rating: bookModel.rating)
        return book
    }
}
