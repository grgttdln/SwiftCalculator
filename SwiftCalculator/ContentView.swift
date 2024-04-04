//
//  ContentView.swift
//  SwiftCalculator
//
//  Created by Georgette Dalen on 4/4/24.
//

import SwiftUI

struct ContentView: View {
    
    let buttons = [
        ["7","8","9","X"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        ["0",".",".","="]
    ]
    
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            Color.black.ignoresSafeArea(.all)
            VStack (spacing: 12) {
                
                HStack {
                    Spacer()
                    Text("42").foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                
                ForEach(buttons, id: \.self) {row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            Text(button)
                                .font(.system(size: 32))
                                .frame(width: self.btnWidth(), height: self.btnWidth())
                                .foregroundColor(.white)
                                .background(Color.yellow)
                                .cornerRadius(self.btnWidth())
                        }
                    }
                }
            }.padding(.bottom)
        }
        
        
        
        
    }
    
    
    func btnWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    
}

#Preview {
    ContentView()
}
