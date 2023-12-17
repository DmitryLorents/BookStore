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
        bookModel.isRecent = true
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
            books.insert(book, at: 0)
        }
        return books
    }
    
    func getRecentBooks() -> [Book] {
        let bookModels = realm.objects(BookModelData.self).filter("isFavorite == false AND isRecent == true")
        var books = [Book]()
        for bookModel in bookModels {
            let book = transferBookModelToBook(bookModel)
            books.insert(book, at: 0)
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
    
    //FIXME: - Работает криво косо
    func addList(_ name: String) {
        let list = ListModelData()
        list.name = name
        try! realm.write {
            realm.add(list)
        }
    }
    
    func addBookToList(_ book: Book, listName: String) {
        let list = realm.objects(ListModelData.self).filter("name == %@", listName).first
        let bookModel = transferBookToBookModel(book)
        bookModel.isFavorite = false
        bookModel.isRecent = false
        if !checkDublicateBookInList(book, listName: listName){
            try! realm.write {
                list?.books.append(bookModel)
                print(list?.books)
            }
        }
    }
    
    func deleteList(_ name: String) {
        let list = realm.objects(ListModelData.self).filter("name == %@", name).first
        try! realm.write {
            realm.delete(list!)
        }
    }
    
    func deleteBookFromList(_ book: Book, listName: String) {
        let list = realm.objects(ListModelData.self).filter("name == %@", listName).first
        let bookModel = transferBookToBookModel(book)
        try! realm.write {
            realm.delete(list!.books.filter("keyForServer == %@", bookModel.keyForServer))
        }
    }
    
    func getListName() -> [ListModel]{
        let lists = realm.objects(ListModelData.self)
        var listsModel = [ListModel]()
        for list in lists {
            listsModel.append(ListModel(name: list.name, books: transferListToArrBook(bookModelDataList: list.books)))
        }
        return listsModel
    }
    
    func checkDublicateList(_ name: String) -> Bool {
        let lists = realm.objects(ListModelData.self)
        for list in lists {
            if list.name == name {
                return true
            }
        }
        return false
    }
    
    func checkDublicateBookInList(_ book: Book, listName: String) -> Bool {
        let list = realm.objects(ListModelData.self).filter("name == %@", listName).first
        for bookModel in list!.books {
            if book.name == bookModel.name {
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
    
    private func transferListToListModelData (_ list: ListModel) -> ListModelData {
        let listModel = ListModelData(name: list.name)
        return listModel
    }
    
    func transferListToArrBook(bookModelDataList: List<BookModelData>) -> [Book] {
        var bookList = [Book]()

        for bookModelData in bookModelDataList {
            let book = transferBookModelToBook(bookModelData)
            bookList.append(book)
        }

        return bookList
    }
}
