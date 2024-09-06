//
//  AddRecipeView.swift
//  RecipeApp
//
//  Created by user266942 on 9/5/24.
//
import SwiftUI

struct AddRecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel // Reference to the view model

    @State private var title = ""
    @State private var description = ""
    @State private var ingredients = [""]
    @State private var instructions = [""]
    @State private var selectedImageName = "defaultImage" // Default image from Assets folder
    @State private var selectedCategory = "Uncategorized" // Default category

    @Environment(\.dismiss) var dismiss // Dismiss action for the view

    // List of available images in the Assets.xcassets folder
    let availableImages = ["selectImage", "spanakopita", "baklava", "cherry-cheesecake", "greek-pasta", "gyros", "cheese-chutney"] // Replace with your actual image names
    
    // List of available categories
    let availableCategories = ["Breakfast", "Lunch", "Dinner", "Dessert", "Salad", "Uncategorized"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Display the selected image from the Assets folder
                    Image(selectedImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                    
                    // Dropdown or Picker to choose an image from the Assets folder
                    Text("Select Image:")
                        .font(.headline)
                        .padding(.bottom, 5)

                    Picker("Select Image", selection: $selectedImageName) {
                        ForEach(availableImages, id: \.self) { imageName in
                            Text(imageName).tag(imageName)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.bottom, 20)

                    // Recipe title input
                    TextField("Recipe Title", text: $title)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    // Recipe description input
                    TextField("Description", text: $description)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)

                    // Category Picker
                    Text("Select Category:")
                        .font(.headline)
                        .padding(.bottom, 5)

                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(availableCategories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.bottom, 20)

                    // Ingredients input
                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.top)

                    ForEach(0..<ingredients.count, id: \.self) { index in
                        TextField("Ingredient", text: $ingredients[index])
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.bottom, 5)
                    }

                    // Button to add more ingredients
                    Button("Add Ingredient") {
                        ingredients.append("")
                    }
                    .padding(.bottom, 10)

                    // Instructions input
                    Text("Instructions:")
                        .font(.headline)
                        .padding(.top)

                    ForEach(0..<instructions.count, id: \.self) { index in
                        TextField("Instruction", text: $instructions[index])
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.bottom, 5)
                    }

                    // Button to add more instructions
                    Button("Add Instruction") {
                        instructions.append("")
                    }
                    .padding(.bottom, 10)

                    // Save button
                    Button("Save Recipe") {
                        // Call addRecipe on the viewModel to save the new recipe
                        viewModel.addRecipe(
                            title: title,
                            description: description,
                            image: selectedImageName,
                            ingredients: ingredients.filter { !$0.isEmpty }, // Filter out empty ingredients
                            instructions: instructions.filter { !$0.isEmpty }, // Filter out empty instructions
                            category: selectedCategory // Use the selected category
                        )
                        dismiss() // Dismiss the view after saving the recipe
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    // Cancel button
                    Button("Cancel") {
                        dismiss() // Dismiss the view without saving
                    }
                    .padding()
                    .foregroundColor(.red)

                    Spacer() // Push content up
                }
                .padding()
            }
            .navigationTitle("Add Recipe")
        }
    }
}
