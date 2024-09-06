//
//  ContentView.swift
//  RecipeApp
//
//  Created by user266942 on 9/4/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = RecipeViewModel() // ViewModel managing the recipes
    @State private var showingAddRecipe = false // State to track whether the AddRecipeView sheet is shown

    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                TextField("Search for recipes...", text: $viewModel.searchQuery)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding([.leading, .trailing], 16)

                // Category filter buttons
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(["All", "Breakfast", "Dinner", "Dessert", "Salad"], id: \.self) { category in
                            Button(action: {
                                viewModel.selectedCategory = category
                            }) {
                                Text(category)
                                    .padding()
                                    .background(viewModel.selectedCategory == category ? Color.blue : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding([.leading, .trailing], 16)
                }

                // Recipe list
                List(viewModel.filteredRecipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        HStack {
                            Image(recipe.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)

                            Text(recipe.title)
                                .font(.headline)
                        }
                    }
                }
                .listStyle(PlainListStyle())

                // Add Recipe Button
                Button(action: {
                    showingAddRecipe.toggle() // Show the AddRecipeView
                }) {
                    Text("Add Recipe")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                .sheet(isPresented: $showingAddRecipe) {
                    AddRecipeView(viewModel: viewModel) // Pass the viewModel to AddRecipeView
                }
            }
            .navigationTitle("Recipes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


