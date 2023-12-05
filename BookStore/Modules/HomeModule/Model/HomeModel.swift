//
//  5Model.swift
//  RainbowApp
//
//
import UIKit

struct Book: Hashable {
    let name: String
    let author: String
    let category: String
}

struct Section: Hashable {
    let type: BookType
    let books: [Book]
}

enum BookType: String {
    case top = "Top Books"
    case recent = "Recent Books"
}

struct BookModel {
    static let sections = [Section(type: .top,
                                   books: [
                                    Book(name: "Жизнь Петра Великого", author: "Антонио Катифоро", category: "Хит"),
                                    Book(name: "В поисках гробниц Древнего Египта", author: "Крис Нонтон", category: "Хит"),
                                    Book(name: "Алгебра счастья", author: "Скотт Гэллоуэй", category: "Хит")
                                   ]), Section(type: .recent,
                                              books: [
                                                Book(name: "Город Петра Великого", author: "Антонио Катифоро", category: "Хит"),
                                                Book(name: "В поисках гробниц Древнего Египта", author: "Крис Нонтон", category: "Хит"),
                                                Book(name: "Алгебра счастья", author: "Скотт Гэллоуэй", category: "Хит")
                                              ])
                                   ]
}
                                   
                                   
                                   
