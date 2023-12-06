//
//  5Model.swift
//  RainbowApp
//
//
import UIKit

struct Book: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let author: String
    let category: String
}

enum Categorie: String, Hashable {
    case week = "This Week"
    case month = "This Month"
    case year = "This Year"
}

enum BookSection: Hashable {
    case categories(title: String, buttonTitle: String, name: [Categorie])
    case top(books: [Book], isHidden: Bool)
    case recent(title: String, buttonTitle: String, books: [Book], isHidden: Bool)
}

struct BookModel {
    static let sections: [BookSection] = [
        .categories(title: "Top Books",
                    buttonTitle: "see more",
                    name: [.week, .month, .year]),
        .top(books: [
            Book(name: "Жизнь Петра Великого", author: "Антонио Катифоро", category: "Хит"),
            Book(name: "В поисках гробниц Древнего Египта", author: "Крис Нонтон", category: "Хит"),
            Book(name: "Алгебра счастья", author: "Скотт Гэллоуэй", category: "Хит")
        ], isHidden: true),
        .recent(title: "Recent Books", buttonTitle: "see more", books: [
            Book(name: "Город Петра Великого", author: "Антонио Катифоро", category: "Хит"),
            Book(name: "В поисках гробниц Древнего Египта", author: "Крис Нонтон", category: "Хит"),
            Book(name: "Алгебра счастья", author: "Скотт Гэллоуэй", category: "Хит")
        ], isHidden: false)
    ]
}



