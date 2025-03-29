import SwiftUI

struct DyslexiaReadingView: View {
    let title: String
    @State var isViewExplanation: Bool = true
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    @State private var isJumping: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("✅ Drag to Read Through Their Eyes").font(.largeTitle).padding()
            
            ZStack {
                
                Color.white
                
                Text(" Dyslexia is a lreaning disroedr that afcfets a pseron's abliity to raed, slpel, wtrie, and smetmoies speka. It is not ralted to intelilgneece, but rthear to how the brian pocrseoss witrten and spoekn lnaguage. Poelpe wtih dyslexia ofetn hvae nromal or eevn abvoe-avreage itnelilgneece, but tehy stgrugle wtih decodnig wrods and recgnoinzing the cnonetcions bteewen ltertes and snodus.\n\nThe eaxct csaue of dyslexia is not flluy udrnsetood, but rseearcehrs bveleie it is lniked to dffreineces in how the brain pcorseoss lnaaguage. It oeftn rnus in fmailies, sgeugtsing a gneetic cpmnoenot. Brian imganig sutdeis sohw taht poelpe wtih dyslexia hvae dffierent atcivity in crteain aeras of the brian rsnepsoible for rdenaig and lnaguage pcorseossing.")
                    .padding()
                    .font(.title)
                    .lineSpacing(10.0)
                    .foregroundStyle(.black)
                    .allowsHitTesting(false)
                
                // 점프하는 텍스트 (마스크 영역에만 보임)
                ZStack {
                    Text(" Dyslexia is a lreaning disroedr that afcfets a pseron's abliity to raed, slpel, wtrie, and smetmoies speka. It is not ralted to intelilgneece, but rthear to how the brian pocrseoss witrten and spoekn lnaguage. Poelpe wtih dyslexia ofetn hvae nromal or eevn abvoe-avreage itnelilgneece, but tehy stgrugle wtih decodnig wrods and recgnoinzing the cnonetcions bteewen ltertes and snodus.\n\nThe eaxct csaue of dyslexia is not flluy udrnsetood, but rseearcehrs bveleie it is lniked to dffreineces in how the brain pcorseoss lnaaguage. It oeftn rnus in fmailies, sgeugtsing a gneetic cpmnoenot. Brian imganig sutdeis sohw taht poelpe wtih dyslexia hvae dffierent atcivity in crteain aeras of the brian rsnepsoible for rdenaig and lnaguage pcorseossing.")
                        .padding()
                        .font(.title)
                        .lineSpacing(10.0)
                        .foregroundStyle(.black)
                        .offset(y: isJumping ? -5 : 0)
                        .animation(
                            Animation.easeInOut(duration: 0.5)
                                .repeatForever(autoreverses: true),
                            value: isJumping
                        )
                }
                .mask(
                    HStack(spacing: 30) {
                        Circle()
                            .frame(width: 150, height: 150)
                        Circle()
                            .frame(width: 150, height: 150)
                    }
                        .offset(x: currentPosition.width, y: currentPosition.height)
                )
                
                ZStack {
                    Rectangle()
                        .foregroundStyle(.black)
                        .opacity(0.9)
                    HStack(spacing: 30) {
                        Circle()
                            .frame(width: 150, height: 150)
                        Circle()
                            .frame(width: 150, height: 150)
                    }
                    .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                    .gesture(DragGesture()
                        .onChanged { value in
                            self.currentPosition = CGSize(
                                width: value.translation.width + self.newPosition.width,
                                height: value.translation.height + self.newPosition.height
                            )
                        }
                        .onEnded { value in
                            self.currentPosition = CGSize(
                                width: value.translation.width + self.newPosition.width,
                                height: value.translation.height + self.newPosition.height
                            )
                            self.newPosition = self.currentPosition
                        })
                    .blendMode(.destinationOut)
                }
                .compositingGroup()
            }
            .ignoresSafeArea(.all, edges: [.bottom, .top])
            .onAppear {
                self.isViewExplanation = false
                self.isJumping = true
            }
        }.navigationTitle(title)
        
    }
}

#Preview {
    DyslexiaReadingView(title: "")
}
