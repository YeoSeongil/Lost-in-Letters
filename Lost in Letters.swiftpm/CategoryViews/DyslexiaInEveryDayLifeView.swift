import SwiftUI

struct DyslexiaInEveryDayLifeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var imageIndex = 0
    @State private var isLongPressed = false 
    
    private let originImage = ["RootMap", "TestPaper", "Receipt", "AirPlaneTicket", "MenuBoard"]
    private let dyslexiaImage = ["DyslexiaRootMap", "DyslexiaTestPaper", "DyslexiaReceipt", "DyslexiaAirPlaneTicket", "DyslexiaMenuBoard"]
    
    let title: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text("✅ Step Into the Shoes of Someone with Dyslexia (Press and hold the image to see the original version!) ")
                    .font(.largeTitle)
                    .padding()
                
                VStack(alignment: .center) {
                    Spacer()
                    
                    HStack {
                        // 이전 이미지 버튼
                        Button(action: {
                            imageIndex = (imageIndex - 1 + dyslexiaImage.count) % dyslexiaImage.count
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .tint(colorScheme == .light ? .black : .white)
                        })
                        .frame(width: 25, height: 35)
                        .padding()
                        
                        Spacer()
                        
                        // 이미지 (길게 누르면 원본으로 변경)
                        Image(isLongPressed ? originImage[imageIndex] : dyslexiaImage[imageIndex])
                            .resizable()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.55)
                            .gesture(
                                DragGesture(minimumDistance: 0) // 드래그 제스처를 사용하여 터치 감지
                                    .onChanged { _ in isLongPressed = true } // 터치 시작할 때 원본 이미지
                                    .onEnded { _ in isLongPressed = false }  // 터치 끝날 때 난독증 이미지
                            )
                        
                        Spacer()
                        
                        // 다음 이미지 버튼
                        Button(action: {
                            imageIndex = (imageIndex + 1) % dyslexiaImage.count
                        }, label: {
                            Image(systemName: "chevron.forward")
                                .resizable()
                                .scaledToFit()
                                .tint(colorScheme == .light ? .black : .white)
                        })
                        .frame(width: 25, height: 35)
                        .padding()
                    }
                    
                    Spacer()
                    
                    // 설명 텍스트
                    Text(dyslexiaInEveryDaySentence[imageIndex].text)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.25)
                        .background(Color.gray.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Spacer()
                }
            }
        }.navigationTitle(title)
    }
}

#Preview {
    DyslexiaInEveryDayLifeView(title: "Dyslexia in Everyday Life")
}
