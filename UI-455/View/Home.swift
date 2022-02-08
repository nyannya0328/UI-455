//
//  Home.swift
//  UI-455
//
//  Created by nyannyan0328 on 2022/02/08.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView{
            
            
            VStack(alignment: .leading, spacing: 13) {
                
                GeometryReader{proxy in
                    
                    
                    let size = proxy.size
                    
                    
                    Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(15)
                    
                    
                   
                }
                .frame(height: 200)
                .padding(.horizontal)
                
                MarWuee(text: "Fox Fox Fox Fox Fox Fox Fox Fox Fox Fox Fox Fox Fox Fox Fox Fox", font: .systemFont(ofSize: 15, weight: .bold))
                
                
            }
            .padding(.vertical)
            .navigationTitle("Marqueee Text")
            
            
            
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct MarWuee : View{
    
    
    @State var text : String
    
    @State var offset : CGFloat = 0
    
    @State  var storedSize : CGSize = .zero
    
    
    var animatedSpeed : Double = 0.015
    
  var delayTime : Double = 0.8
    
    
    @Environment(\.colorScheme) var scehme
    


    var font : UIFont
    
    var body: some View{
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            
            
            Text(text)
                .font(Font(font))
                .offset(x: offset)
                .padding(.horizontal,15)
           
            
            
            
        }
        .overlay{
            
            
            
            HStack{
                
                
                
                let color : Color = scehme == .dark ? .black : .white
                
                
                
                LinearGradient(colors: [
                    
                    
                    color.opacity(0.7),
                    color.opacity(0.5),
                    color.opacity(0.3),
                    color.opacity(0.2),
                
                
                
                
                ], startPoint: .leading, endPoint: .trailing).frame(width: 20)
                
                Spacer()
                
                
                LinearGradient(colors: [
                    
                    
                    color.opacity(0.7),
                    color.opacity(0.5),
                    color.opacity(0.3),
                    color.opacity(0.2),
                
                
                
                
                ].reversed(), startPoint: .leading, endPoint: .trailing).frame(width: 20)
                
            }
            
            
        }
       .disabled(true)
       .onAppear {
           
           
           let baseText = text
           
           (1...15).forEach { _ in
               
               
               
               text.append(" ")
           }
           
           storedSize = textSize()
           text.append(baseText)
           
           
           let timing : Double = (animatedSpeed * storedSize.width)
           
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               
               
               
               withAnimation(.linear(duration: timing)){
                   
                   
                   offset = -storedSize.width
               }
               
           }
           
           
        
           
           
           
       }
       .onReceive(Timer.publish(every: ((animatedSpeed * storedSize.width) + delayTime), on: .main, in: .default).autoconnect()) { _ in
           
           
           offset = 0
           
           withAnimation(.linear(duration: (animatedSpeed * storedSize.width))){
               
               
               offset = -storedSize.width
           }
           
           
       }
       
    }
    func textSize()->CGSize{
        
        let attributes = [NSAttributedString.Key.font:font]
        
        let size = (text as NSString).size(withAttributes: attributes)
        
        return size
        
    }
    
}
