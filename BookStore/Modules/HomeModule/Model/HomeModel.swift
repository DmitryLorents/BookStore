//
//  HomeModel.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit

// MARK: - Book Model

struct Book: Hashable, Identifiable {
    let id = UUID()
    let key: String
    let name: String
    let author: String
    let category: String
    let imageID: Int
    let rating: Double
}

// MARK: - Categories

enum HomeCategory: String, Hashable, CaseIterable {
    case week = "This Week"
    case month = "This Month"
    case year = "This Year"
}

// MARK: - Sections

enum BookSection: Int, Hashable, CaseIterable {
    case categories
    case top
    case recent
}

// MARK: - HomeViewModel

struct HomeViewModel {
    let topBooks: [Book]
    let recentBooks: [Book]
    let topBooksHeader: Header
    let categories = HomeCategory.allCases
    let recentBooksHeader: Header
    
    struct Header {
        let title: String
        let button: Button
    }
    
    struct Button {
        let title: String
        let action: () -> Void
    }
}


