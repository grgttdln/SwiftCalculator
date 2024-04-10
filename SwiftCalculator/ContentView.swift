//
//  ContentView.swift
//  SwiftCalculator
//
//  Created by Georgette Dalen on 4/4/24.
//

import SwiftUI

class GlobalEnvironment: ObservableObject   {
    
    @Published var display = ""
    var fNum = 0.0
    var sNum = 0.0
    var operation = ""
    var isEqual = false
    
    func receiveInput(calcBtn: CalculatorButton) {
        
        let operators: [String] = ["/", "X", "-", "+", "="]
        
        if calcBtn.title == "AC" {
            fNum = 0.0
            sNum = 0.0
            operation = ""
            display = ""
            isEqual = false
        }
        else if calcBtn.title == "%" {
            fNum = Double(display) ?? 0.0
            fNum /= 100
            display = "\(fNum)"

        } else if calcBtn.title == "+/-" {
            fNum = Double(display) ?? 0.0
            fNum *= -1
            display = "\(fNum)"
        } else {
            if operators.contains(calcBtn.title) {
                
                if calcBtn.title == "=" && !operation.isEmpty {
                    sNum = Double(display) ?? 0.0
                    switch operation {
                    case "X":
                        fNum *= sNum
                        display = "\(fNum)"
                    case "+":
                        fNum += sNum
                        display = "\(fNum)"
                    case "-":
                        fNum -= sNum
                        display = "\(fNum)"
                    case "/":
                        if sNum != 0 {
                            fNum /= sNum
                            display = "\(fNum)"
                        } else {
                            display = "Error"
                        }
                    default:
                        display = "0"
                    }
                    
                    isEqual = true
                }
                else {
                    fNum = Double(display) ?? 0.0
                    operation = calcBtn.title
                    display = ""
                }
            } else {
                if isEqual {
                    self.display = calcBtn.title
                    isEqual = false
                } else {
                    self.display += calcBtn.title
                }
                
               
            }
        }
    }
    
}



enum CalculatorButton {
    
    case zero, one, two, three, four, five, six, seven, eight, nine
    case decimal
    case equals, plus, minus, multiply, divide
    case ac, sign, percent
    
    
    var title: String {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiply:
            return "X"
        case .divide:
            return "/"
        case .ac:
            return "AC"
        case .sign:
            return "+/-"
        case .percent:
            return "%"
        case .equals:
            return "="
        case .decimal:
            return "."
        default:
            return "0"
        }
    }
    
    var bgColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .sign, .percent:
            return Color(.lightGray)
        default:
            return Color(.orange)
        }
    }
    
    
}





struct ContentView: View {
    
    @EnvironmentObject var envCalculator: GlobalEnvironment
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .sign, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            Color.black.ignoresSafeArea(.all)
            VStack (spacing: 12) {
                
                HStack {
                    Spacer()
                    Text(envCalculator.display).foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                
                ForEach(buttons, id: \.self) {row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            
                            Button(action: {
                                
                                self.envCalculator.receiveInput(calcBtn: button)
                                
                            }) {
                                Text(button.title)
                                    .font(.system(size: 32))
                                    .frame(width: self.btnWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                                    .foregroundColor(.white)
                                    .background(button.bgColor)
                                    .cornerRadius(self.btnWidth(button: button))
                            }
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
    
    
    func btnWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    
}

#Preview {
    ContentView().environmentObject(GlobalEnvironment())
}
