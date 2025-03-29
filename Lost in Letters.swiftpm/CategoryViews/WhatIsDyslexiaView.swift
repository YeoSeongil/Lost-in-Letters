import SwiftUI

struct WhatIsDyslexiaView: View {
    let title: String
    
    private let symptoms: [String] = ["🔡 Difficulty reading or spelling words",
                                      "🔄 Confusing the order of numbers or letters",
                                      "🌫️ Words or sentences appear blurry",
                                      "🧐 Words or sentences appear fragmented",
                                      "🧐 Words seem to float when reading long texts"
    ]
    
    private let causes: [String] = [
        "🧠 Differences in brain structure and function",
        "🧬 Genetic factors and family history",
        "👶 Issues during early brain development",
        "📚 Limited exposure to language and reading in early childhood"
    ]
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    Image("dyslexia")
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 12))
                    
                    Text("Dyslexia")
                        .font(.title)
                        .bold()
                    
                    Text("Dyslexia is a neurological condition that affects reading, writing, and spelling abilities. It is not related to intelligence but rather to how the brain processes language. People with dyslexia may have difficulty recognizing words, decoding letters, and understanding written text, even though they often have normal vision and cognitive abilities.")
                        .font(.title2)
                }.padding()
            }
            
            
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Symptoms")
                        .font(.title)
                        .bold()
                    
                    Text("The symptoms of dyslexia vary from person to person. Some may struggle with spelling, while others may mix up the order of letters or numbers. Words might appear blurry, fragmented, or even seem to float when reading long texts. These challenges can differ widely, but they all affect the way individuals process written language.")
                        .font(.title2)
                        .padding(.bottom, 10)
                    ForEach(symptoms, id: \.self) { symptom in
                        Text(symptom)
                    }.padding(.top, -7)
                }
            }.padding()
            
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Causes")
                        .font(.title)
                        .bold()
                    
                    Text("Dyslexia is primarily caused by differences in the brain's structure and function, particularly in areas responsible for language processing. Genetic factors play a significant role, as dyslexia often runs in families. Other factors, such as early brain development and environmental influences, may also contribute to the condition.")
                        .font(.title2)
                        .padding(.bottom, 10)
                    
                    ForEach(causes, id: \.self) { cause in
                        Text(cause)
                    }.padding(.top, -7)
                }
            }.padding()
            
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Additional Information")
                        .font(.title)
                        .bold()
                    
                    Text("Dyslexia is not a sign of low intelligence or laziness. Many individuals with dyslexia have unique strengths, including creativity, problem-solving skills, and strong verbal abilities. With proper support and teaching strategies, people with dyslexia can thrive in academic and professional settings.")
                        .font(.title2)
                }
            }.padding()
        }.navigationTitle(title)
    }
}

#Preview {
    WhatIsDyslexiaView(title: "What is Dyslexia?")
}
