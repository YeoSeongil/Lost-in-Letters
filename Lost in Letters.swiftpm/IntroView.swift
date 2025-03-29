import SwiftUI

struct IntroView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var introIndex = 0
    @State private var isFinish = false
    @State private var navigateToMain = false 
    @State private var introText = [
        "Teh qciuk borwn fix jmups oevr teh lzay odg.",
        "This is what reading feels like for some people.",
        "Not everyone sees words like you do.",
        "Reading isn't easy for everyone.",
        "Imagine if every word looked like this.",
        "Ready to step into their world?"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear.contentShape(Rectangle())
                
                VStack {
                    Spacer()
                    Text(introText[introIndex])
                        .font(.system(size: 50, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    if introIndex == 0 {
                        Text("Can you this read?")
                            .padding(.top, -5)
                            .font(.system(size: 50, weight: .semibold))
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    if isFinish {
                        Button(action: {
                            tapEvent()
                        }, label: {
                            Image(systemName: "chevron.forward")
                                .tint(colorScheme == .light ? .black : .white)
                                .font(.system(size: 50))
                        })
                        .padding(.bottom, 100)
                    }
                }
            }
            .onTapGesture {
                animationText()
            }
            
            .navigationDestination(isPresented: $navigateToMain) {
                MainView()
            }
        }
    }
}

private extension IntroView {
    func tapEvent() {
        if introIndex < introText.count - 1 {
            introIndex += 1
        } else {
            navigateToMain = true
        }
    }
    
    func animationText() {
        var tempText = Array(introText[0])
        let originText = Array("The quick brown fox jumps over the lazy dog.")
        var index = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if index < tempText.count - 1 {
                withAnimation {
                    tempText[index] = originText[index]
                    introText[0] = String(tempText)
                }
                index += 1
            } else {
                timer.invalidate()
                isFinish = true
            }
        }
    }
}

#Preview {
    IntroView()
}
