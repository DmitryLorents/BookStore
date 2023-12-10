//
//  HomeModel.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit

struct Book: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let author: String
    let category: String
    let imageID: Int
}

enum HomeCategory: String, Hashable, CaseIterable {
    case week = "This Week"
    case month = "This Month"
    case year = "This Year"
}

enum BookSection: Hashable, CaseIterable {
    case categories
    case top
    case recent
}



