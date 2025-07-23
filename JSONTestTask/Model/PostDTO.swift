//
//  Post.swift
//  JSONTestTask
//
//  Created by Даниил Иваньков on 22.07.2025.
//

struct PostDTO: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
