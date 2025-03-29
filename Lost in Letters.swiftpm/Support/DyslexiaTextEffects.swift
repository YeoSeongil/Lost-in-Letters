import SwiftUI

class DyslexiaTextEffects: ObservableObject {
    @Published var timer: Timer?
    
    func scrambleText(original: String) -> String {
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
    
    func replaceSimilarCharacters(in text: String) -> String {
        let mapping: [Character: Character] = [
            "0": "o", "o": "0",
            "w": "n", "n": "u", "u": "n",
            "l": "1", "i": "1", "1": "l",
            "d": "b", "b": "q", "q": "b",
        ]
        
        return String(text.map { mapping[$0] ?? $0 })
    }
    
    func startScramblingEffect(selectedIndex: Int, fourthEffIsOn: Bool, updateText: @escaping (String) -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            let scrambledText = self.scrambleText(original: dyslexiaSentences[selectedIndex].text)
            updateText(fourthEffIsOn ? self.replaceSimilarCharacters(in: scrambledText) : scrambledText)
        }
    }
    
    func stopScramblingEffect(updateText: @escaping () -> Void) {
        timer?.invalidate()
        timer = nil
        updateText()
    }
}
