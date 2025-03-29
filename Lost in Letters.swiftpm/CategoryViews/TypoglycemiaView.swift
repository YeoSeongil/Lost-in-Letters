import SwiftUI

struct TypoglycemiaView: View {
    @State private var isOn = false
    let title: String
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        if isOn {
                            Text("What is Typoglycemia?")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                        } else {
                            Text("Waht is Tyopgolycemia?")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                        }
                        
                        Toggle(isOn: $isOn, label: {
                            EmptyView()
                        })
                    }
                    
                    if isOn {
                        Text("Have you ever read something that looks completely jumbled but still makes sense? This is called typoglycemia—a phenomenon where as long as the first and last letters of a word are in place, the brain can automatically interpret the meaning.")
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .padding(.top, 10)
                        
                        Text("Dyslexia sometimes causes text to appear scrambled, making reading a challenge. But even people without dyslexia can experience this effect.")
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .padding(.top, 5)
                    } else {
                        Text("Hvae you eevr raed smoehtnig taht lokos cmopletley jmubeld but sltil maeks snese? Tihs is alled tyopgolycemia—a pohnemoneon wehre as lnog as the fsrit and lsat lteetrs of a wrod are in pacle, the bairn can atotmaucially ipnreert the mninaeg.")
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .padding(.top, 10)
                        
                        Text("Dyslxiea sneotimes cuases txet to apepar scmarbled, mnkaig ridaeng a cnhallge. But even poelpe wtihout dyelsixa can epxerenice tihs efcfet.")
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .padding(.top, 5)
                    }
                }.padding()
            }
        }
        
        .navigationTitle(title)
    }
}

#Preview {
    TypoglycemiaView(title: "Typoglycemia")
}
