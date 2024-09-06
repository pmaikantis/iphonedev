//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by user266942 on 9/4/24.
//

import Foundation
import Combine

class RecipeViewModel: ObservableObject {
    @Published var recipes = [Recipe]() {
        didSet {
            saveRecipes() // Save recipes to persistence when the array changes
        }
    }
    @Published var searchQuery = "" // For search functionality
    @Published var selectedCategory = "All" // For category filtering
    
    private let recipesKey = "savedRecipes" // Key for saving recipes in UserDefaults

    // Initialize with saved data or sample data
    init() {
        loadRecipes()
    }

    // Add a new recipe
    func addRecipe(title: String, description: String, image: String, ingredients: [String], instructions: [String], category: String) {
        let newRecipe = Recipe(title: title, description: description, image: image, ingredients: ingredients, instructions: instructions, category: category)
        recipes.append(newRecipe)
    }

    // Filtered recipes based on search and category
    var filteredRecipes: [Recipe] {
        return recipes.filter { recipe in
            let matchesCategory = selectedCategory == "All" || recipe.category == selectedCategory
            let matchesSearch = searchQuery.isEmpty || recipe.title.localizedCaseInsensitiveContains(searchQuery)
            return matchesCategory && matchesSearch
        }
    }

    // MARK: - Persistence with UserDefaults

    // Save recipes to UserDefaults
    private func saveRecipes() {
        if let encoded = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(encoded, forKey: recipesKey)
        }
    }

    // Load recipes from UserDefaults
    private func loadRecipes() {
        if let savedData = UserDefaults.standard.data(forKey: recipesKey),
           let decodedRecipes = try? JSONDecoder().decode([Recipe].self, from: savedData) {
            recipes = decodedRecipes
        } else {
            loadSampleData() // If no saved data, load sample recipes
        }
    }

    // Sample data to use when no saved data exists
    private func loadSampleData() {
        self.recipes = [
            Recipe(
                title: "Greek Salad",
                description: "The perfect Greek salad with fresh tomatoes, cucumbers, red onions, green peppers, romaine lettuce, olives and feta cheese tossed in Greek salad dressing.",
                image: "greek-salad",
                ingredients: [
                    "3 cups romaine lettuce, chopped",
                    "1 cup grape tomatoes",
                    "1 cup red onion, chopped",
                    "1 + ½ cups cucumber, sliced",
                    "1 medium green pepper, chopped",
                    "¼ cup whole Kalamata olives",
                    "¼ cup feta cheese, crumbled",
                    "2 tablespoons extra virgin olive oil",
                    "1 + ½ tablespoons freshly squeezed lemon juice",
                    "½ teaspoon dried oregano",
                    "¼ teaspoon sea salt",
                    "¼ teaspoon ground black pepper"
                ],
                instructions: [
                    "Prep and combine the romaine lettuce, cherry tomatoes, red onion, cucumber, green peppers, olives and feta cheese in a large bowl.",
                    "In a small bowl, make the lemon Greek salad dressing by whisking together the olive oil, lemon juice, oregano, salt and pepper.",
                    "Pour the dressing over the salad and toss to combine. Add more black pepper to taste."
                ],
                category: "Salad"
            ),
            Recipe(
                title: "Breakfast Bowls",
                description: "Start your day well with these Healthy Breakfast Meal Prep Bowls. Sweet potato frittata, roasted cashews and berries are all you need to have nutritious breakfast all week long.",
                image: "breakfast-bowls",
                ingredients: [
                    "2 tablespoons olive oil",
                    "½ medium onion chopped",
                    "1 large red bell pepper chopped",
                    "2 cups diced roasted sweet potato",
                    "2 cup spinach",
                    "5 large eggs lightly beaten",
                    "½ cup almond milk",
                    "¼ tsp crushed red peppers",
                    "1 tablespoon dried parsley",
                    "Salt and pepper"
                ],
                instructions: [
                    "Preheat oven to 400°F.",
                    "Over medium-high heat, heat oil in a 9-inch cast iron skillet.",
                    "Add onion and cook until slightly golden brown.",
                    "Add peppers and cook for 3-5 minutes.",
                    "Add roasted sweet potato and spinach. Stir well and cook for 1 minute.",
                    "In a medium bowl whisk eggs, almond milk, red flake peppers, dried parsley, salt, and pepper.",
                    "Pour the egg mixture into the cast iron skillet, making sure eggs cover the vegetable mixture.",
                    "When the edges of the frittata begin to set, move the skillet to the oven.",
                    "Bake it for about 10-15 minutes or until frittata is completely cooked."
                ],
                category: "Breakfast"
            ),
            Recipe(
                title: "Breakfast Burritos",
                description: "Make ahead breakfast burritos are an easy reheatable and portable breakfast meal prep idea. Including options for vegetarian or other add-ins!",
                image: "breakfast-burritos",
                ingredients: [
                    "8 oz. cheddar",
                    "1 yellow onion",
                    "1 bell pepper",
                    "2 Tbsp butter, divided",
                    "2 pinches salt and pepper",
                    "1 lb. cooked ham",
                    "12 large eggs",
                    "8 large flour tortillas (burrito size)"
                ],
                instructions: [
                    "Begin by preparing all of the filling ingredients for the breakfast burritos. Shred the cheddar, if not purchased pre-shredded.",
                    "Dice the onion and bell pepper. Add the onion and bell pepper to a large skillet with ½ Tbsp butter and sauté over medium heat until the onions are soft and translucent (about 5 minutes). Season the bell pepper and onion with a pinch of salt and pepper. Transfer the bell pepper and onion to a bowl.",
                    "Dice the ham, then add it to the skillet with another ½ Tbsp butter. Sauté the ham over medium heat until it is browned (about 5 minutes). Transfer the ham to a separate bowl and clean the skillet.",
                    "Crack 12 eggs into a bowl and lightly whisk. Add the last tablespoon butter to the skillet and heat over medium. Once the skillet is hot, spread the butter to coat the surface, then pour in the whisked eggs.",
                    "Push the eggs in toward the center of the skillet as they set on the bottom, until most of the eggs have set, but the eggs still look moist. Do not over cook the eggs or they'll become dry. Season the eggs with a pinch of salt and pepper."
                ],
                category: "Breakfast"
            ),
            Recipe(
                title: "Shrimp Pasta",
                description: "Creamy Shrimp Pasta in a garlic, parmesan cream sauce is an easy weeknight dinner!",
                image: "seafood-pasta",
                ingredients: [
                    "12 ounces linguine pasta dry weight",
                    "½ cup reserved pasta water",
                    "2 tablespoons olive oil divided",
                    "4 cloves garlic minced, divided",
                    "1 yellow onion chopped",
                    "8 ounces brown mushrooms sliced",
                    "1 pound fresh shrimp without shells, washed and deveined",
                    "½ teaspoon crushed red pepper flakes adjust to suit your tastes",
                    "1 teaspoon mild paprika",
                    "1 pinch salt to taste",
                    "8 ounces cream cheese at room temperature",
                    "2 cups milk",
                    "½ cup parmesan cheese grated",
                    "½ cup light mozzarella cheese shredded",
                    "2 tablespoons fresh parsley chopped to garnish"
                ],
                instructions: [
                    "Cook pasta according to package instructions in a pot of salted boiling water; drain and rinse reserving ½ cup of the pasta water. Set it aside for later.",
                    "While pasta is boiling, heat a large frying pan/skillet on medium-high heat. Add 1 tablespoon of the olive oil to the pan and fry half of the garlic for about 30 seconds; add the onions, and continue sautéing until soft. Add the mushrooms and fry while occasionally stirring, until the mushrooms have browned. Stir through 1-2 tablespoons of water and cook them for a further minute. Transfer mushrooms to a plate and set it aside.",
                    "To the same pan, add the remaining oil. Sauté remaining garlic until fragrant. Add the shrimp and cook until they just begin to change color. Add the pepper flakes, paprika and salt.",
                    "Cook while occasionally stirring for a further 1-2 minutes to combine all the flavours in the pan. Add the mushrooms to the pan, stirring them through the flavours in the pan. Transfer the shrimp/mushroom mixture to the same plate the mushrooms were on.",
                    "Add the cream cheese and milk to the same pan and bring to a gentle simmer while stirring occasionally. Allow to simmer for about 5 minutes, then add the cheeses. Once the cheese has melted through, taste test and season with a little salt (if needed).",
                    "Add the shrimp/mushroom mix along with the pasta into the creamy sauce, stirring everything through for a further 2 minutes on low heat. Add the reserved pasta water -- ¼ cup at a time -- only if needed or until reaching your desired consistency."
                ],
                category: "Dinner"
            )
        ]
    }
}


