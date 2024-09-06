//
//  RecipeDetailView.swift
//  RecipeApp
//
//  Created by user266942 on 9/4/24.
//
import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe

    var body: some View {
        TabView {
            // Description view
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.headline)
                        .padding(.bottom, 5)

                    Text(recipe.description)
                        .padding()
                }
                .padding()
            }
            .tabItem {
                Text("Description")
            }

            // Ingredients view
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.bottom, 5)

                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                            .padding(.bottom, 2)
                    }
                }
                .padding()
            }
            .tabItem {
                Text("Ingredients")
            }

            // Instructions view
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Instructions")
                        .font(.headline)
                        .padding(.bottom, 5)

                    ForEach(recipe.instructions, id: \.self) { instruction in
                        Text(instruction)
                            .padding(.bottom, 2)
                    }
                }
                .padding()
            }
            .tabItem {
                Text("Instructions")
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // Enables swipe gestures between tabs
        .navigationTitle(recipe.title)
    }
}


