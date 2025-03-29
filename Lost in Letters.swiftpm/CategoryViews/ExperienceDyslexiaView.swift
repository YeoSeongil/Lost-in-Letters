import SwiftUI

struct ExperienceDyslexiaView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showToolTip = false
    @State private var randomScrambleIsOn = false
    @State private var confusingIsOn = false
    @State private var diagonalMoveIsOn = false
    @State private var fontEffIsOn = false
    
    @State private var selectedSentenceIndex = 0
    @State private var displayedText: String = ""
    @State private var timer: Timer?
    @State private var textOffset: CGSize = .zero
    
    @State private var fontSize =  28.0
    @State private var tracking =  0.0
    @State private var lineSpacing =  0.0
    @State private var fontColor: Color = .primary
    @State private var backgroundColor: Color = Color.clear
    @State private var fontOverlapIsOn = false
    
    let title: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 10) {
                Text("✅ Choose a symptom to experience how dyslexia affects reading.")
                    .font(.largeTitle)
                
                Spacer()
                
                VStack {
                    HStack(spacing: 30) {
                        Button(action: {
                            selectedSentenceIndex = (selectedSentenceIndex - 1 + dyslexiaSentences.count) % dyslexiaSentences.count
                            updateText()
                        }, label: {
                            Image(systemName: "chevron.backward").resizable().scaledToFit()
                                .tint(colorScheme == .light ? .black : .white)
                        })
                        .frame(width: 25, height: 35)
                        .padding()
                        
                        Spacer()
                        
                        ZStack {
                            ForEach(0..<3, id: \.self) { i in
                                Text(displayedText)
                                    .foregroundStyle(fontColor)
                                    .font(fontEffIsOn ? customFont(size: fontSize) : .system(size: fontSize))
                                    .tracking(tracking)
                                    .lineSpacing(lineSpacing)
                                    .multilineTextAlignment(.leading)
                                    .opacity(fontOverlapIsOn ? 0.7 : 1)
                                    .offset(x: fontOverlapIsOn ? CGFloat(i * 2 - 2) : 0,
                                            y: fontOverlapIsOn ? CGFloat(i * 2 - 2) : 0)
                                    .blur(radius: fontOverlapIsOn ? 0.8 : 0)
                            }
                        }
                        .padding(30)
                        .background(backgroundColor)
                        .clipShape(.rect(cornerRadius: 15))
                        .offset(textOffset)
                        .onAppear {
                            updateText()
                            registerCustomFont()
                        }
                        .onChange(of: randomScrambleIsOn) { isOn in
                            isOn ? startScramblingEffect() : stopScramblingEffect()
                        }
                        .onChange(of: confusingIsOn) { _ in updateText() }
                        .onChange(of: diagonalMoveIsOn) { isOn in
                            if isOn {
                                startDiagonalAnimation()
                            } else {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    textOffset = .zero
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            selectedSentenceIndex = (selectedSentenceIndex + 1) % dyslexiaSentences.count
                            updateText()
                        }, label: {
                            Image(systemName: "chevron.forward").resizable().scaledToFit()
                                .tint(colorScheme == .light ? .black : .white)
                        })
                        .frame(width: 25, height: 35)
                        .padding()
                    }
                    .frame(height: geometry.size.height * 0.48)
                    .background(.gray.opacity(0.15))
                    .clipShape(.rect(cornerRadius: 15))
                    
                    Spacer()
                    
                    HStack(spacing: 30) {
                        VStack(alignment: .leading) {
                            Text("Symptoms").font(.largeTitle)
                            Spacer()
                            Toggle("Text randomly scrambles.", isOn: $randomScrambleIsOn).font(.title2)
                            Toggle("Similar-looking letters appear confusing.", isOn: $confusingIsOn).font(.title2)
                            Toggle("Text moves diagonally.", isOn: $diagonalMoveIsOn).font(.title2)
                            Toggle("Text overlaps.", isOn: $fontOverlapIsOn).font(.title2)
                            Spacer()
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.49, height: geometry.size.height * 0.4)
                        .background(.gray.opacity(0.15))
                        .clipShape(.rect(cornerRadius: 15))
                        
                        VStack(alignment: .leading) {
                            Text("Adjust for Better Reading").font(.largeTitle)
                            Spacer()
                            HStack {
                                Toggle("Apply OpenDyslexic Font", isOn: $fontEffIsOn).font(.title2)
                                Button {
                                    showToolTip.toggle()
                                } label: {
                                    Image(systemName: "questionmark.circle")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                }
                                .popover(isPresented: $showToolTip) {
                                    Text("The OpenDyslexic font is designed to improve readability for individuals with dyslexia.\nIt features weighted bottoms on letters to help prevent them from flipping or rotating while reading.").font(.title2).padding()
                                }
                            }
                            HStack {
                                Text("Font Size").font(.title2)
                                Spacer()
                                Slider(value: $fontSize,
                                       in: 28...40).frame(width: geometry.size.width * 0.35)
                            }
                            HStack {
                                Text("Tracking").font(.title2)
                                Spacer()
                                Slider(value: $tracking,
                                       in: 0...15).frame(width: geometry.size.width * 0.35)
                            }
                            HStack {
                                Text("LineSpacing").font(.title2)
                                Spacer()
                                Slider(value: $lineSpacing,
                                       in: 0...30).frame(width: geometry.size.width * 0.35)
                            }
                            HStack {
                                ColorPicker(selection: $fontColor, supportsOpacity: true) {
                                    Text("Select a Font Color").font(.title2)
                                }
                            }
                            HStack {
                                ColorPicker(selection: $backgroundColor, supportsOpacity: true) {
                                    Text("Select a Background Color").font(.title2)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.49, height: geometry.size.height * 0.4)
                        .background(.gray.opacity(0.15))
                        .clipShape(.rect(cornerRadius: 15))
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .padding(30)
        .navigationTitle(title)
    }
    
    
    private func startScramblingEffect() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            let scrambledText = scrambleText(original: dyslexiaSentences[selectedSentenceIndex].text)
            displayedText = confusingIsOn ? replaceSimilarCharacters(in: scrambledText) : scrambledText
        }
    }
    
    private func stopScramblingEffect() {
        timer?.invalidate()
        timer = nil
        updateText()
    }
    
    private func updateText() {
        let originalText = dyslexiaSentences[selectedSentenceIndex].text
        displayedText = confusingIsOn ? replaceSimilarCharacters(in: originalText) : originalText
    }
    
    private func startDiagonalAnimation() {
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            textOffset = CGSize(width: 20, height: -20)
        }
    }
    
    private func replaceSimilarCharacters(in text: String) -> String {
        let mapping: [Character: Character] = [
            "0": "o", "o": "0",
            "w": "n", "n": "u", "u": "n",
            "l": "1", "i": "1", "1": "l",
            "d": "b", "b": "q", "q": "b",
        ]
        
        return String(text.map { mapping[$0] ?? $0 })
    }
    
    private func scrambleText(original: String) -> String {
        let words = original.split(separator: " ")
        return words.map { word in
            if word.count > 3 {
                let middle = word.dropFirst().dropLast().shuffled()
                return "\(word.first!)\(String(middle))\(word.last!)"
            } else {
                return String(word)
            }
        }.joined(separator: " ")
    }
    
    private func registerCustomFont() {
        guard let fontURL = Bundle.main.url(forResource: "OpenDyslexic-Regular", withExtension: "otf"),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            print("❌ 폰트 파일을 찾을 수 없습니다.")
            return
        }
        
        var error: Unmanaged<CFError>?
        if CTFontManagerRegisterGraphicsFont(font, &error) {
        } else {
        }
    }
    
    private func customFont(size: CGFloat) -> Font {
        return Font.custom("OpenDyslexic-Regular", size: size - 6)
    }
}

#Preview {
    ExperienceDyslexiaView(title: "Experience Dyslexia")
}
