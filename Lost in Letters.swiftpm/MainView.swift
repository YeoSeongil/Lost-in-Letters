import SwiftUI

struct MainView: View {
    @State private var selectedCategory: String? = "What is Dyslexia?"
    private let categories = ["What is Dyslexia?", "Typoglycemia", "Experience Dyslexia", "Read Through Their Eyes", "Dyslexia in Everyday Life"]
    
    var body: some View {
        NavigationSplitView {
            List(categories, id: \.self, selection: $selectedCategory) { category in
                Text(category)
                    .padding()
            }
            .navigationTitle("Categories")
        } detail: {
            if let selectedCategory = selectedCategory {
                switch selectedCategory {
                case "What is Dyslexia?":
                    WhatIsDyslexiaView(title: selectedCategory)                
                case "Typoglycemia":
                    TypoglycemiaView(title: selectedCategory)
                case "Experience Dyslexia":
                    ExperienceDyslexiaView(title: selectedCategory)
                case "Read Through Their Eyes":
                    DyslexiaReadingView(title: selectedCategory)                
                case "Dyslexia in Everyday Life":
                    DyslexiaInEveryDayLifeView(title: selectedCategory)
                default:
                    WhatIsDyslexiaView(title: selectedCategory)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainView()
}
