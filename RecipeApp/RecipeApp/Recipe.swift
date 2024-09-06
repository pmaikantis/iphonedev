//
//  Recipe.swift
//  RecipeApp
//
//  Created by user266942 on 9/4/24.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id = UUID() // Default value for UUID
    var title: String
    var description: String
    var image: String
    var ingredients: [String]
    var instructions: [String]
    var category: String

    // Provide an explicit initializer if needed
    init(id: UUID = UUID(), title: String, description: String, image: String, ingredients: [String], instructions: [String], category: String) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.ingredients = ingredients
        self.instructions = instructions
        self.category = category
    }
}


