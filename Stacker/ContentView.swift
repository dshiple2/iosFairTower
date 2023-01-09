//
//  ContentView.swift
//  Stacker
//
//  Created by David Shipley on 1/2/23.
//

import SwiftUI
import AVFoundation

var time = 0.5

//var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

struct ContentView: View {
    var columns = 9
    var rows = 9
    @State var timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    @State var score = 0
    @State var currBlock: [Int] = [3,4,5]
    @State var lastRowBlock: [Int] = [3,4,5]
    @State var currIndex = 0
    @State var newCurrBlock: [Int] = []
    @State var fallOffSquares: Set<Int> = []
    @State var currDirection = "R"
    @State var currRow = 8
    @State var showText = false
    @State var colors: [[Color]] = [[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .blue, .blue, .blue, .gray, .gray, .gray]]
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: 0, green: 0.151, blue: 0.195).ignoresSafeArea()
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(lineWidth: 8.0)
                    .foregroundColor(.white)
                    .frame(width:350.0)
                    .frame(height: 800.0)
                    .zIndex(1)
                RoundedRectangle(cornerRadius: 20.0)
                    .stroke(lineWidth: 8.0)
                    .foregroundColor(.white)
                    .frame(width: 275.0)
                    .frame(height: 700.0)
                    .zIndex(1)
                RoundedRectangle(cornerRadius: 15.0)
                    .stroke(lineWidth: 8.0)
                    .foregroundColor(.white)
                    .frame(width: 180.0)
                    .frame(height: 600.0)
                    .zIndex(1)
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(Color(red: 0, green: 0.151, blue: 0.195))
                    .frame(height: 450)
                    .zIndex(2)
                VStack{
                    ForEach(0...8, id: \.self) { x in
                        HStack {
                            ForEach(0...8, id: \.self) { y in
                                Rectangle()
                                    .foregroundColor(colors[x][y])
                                    .frame(width:38.0)
                                    .frame(height:38.0)
                            }
                        }
                        .padding(.horizontal, -2.0)
                    }
                }
                .zIndex(3)
                .padding(.vertical, 200)
                .onReceive(timer, perform: { _ in
                    if currRow > -1 && !currBlock.isEmpty {
                        if currDirection == "R" {
                            forwardMove()
                        }
                        if currDirection == "L" {
                            backwardMove()
                        }
                        
                    }
                    if currBlock.isEmpty {
                        showText = true
                    }
                })
                .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .global)
                            .onChanged { _ in
                                score = score + 1
                                if currRow != rows - 1 {
                                    fallOffSquares = Set(currBlock).subtracting(Set(lastRowBlock))
                                    currBlock = currBlock.filter { !fallOffSquares.contains($0)}
                                    if !currBlock.isEmpty {
                                        for square in fallOffSquares {
                                            colors[currRow][square] = .gray
                                        }
                                    }
                                    lastRowBlock = currBlock.map { $0 }
                                    if currRow > 0 {
                                        currRow = currRow - 1
                                        for block in currBlock {
                                            colors[currRow][block] = .blue
                                        }
                                    } else {
                                        colors = [[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray]]
                                        currRow = rows - 1
                                        for square in currBlock {
                                            colors[currRow][square] = .blue
                                        }
                                        currRow = currRow - 1
                                    }
                                } else {
                                    lastRowBlock = currBlock.map { $0 }
                                    currRow = currRow - 1
                                    for block in currBlock {
                                        colors[currRow][block] = .blue
                                    }
                                }
                                if score > 6 {
                                    timer = Timer.publish(every: 0.08, on: .main, in: .common).autoconnect()
                                }
                                else if score > 2 {
                                    timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                                }
                            }
                            .onEnded { _ in
                            }
                    )
                .padding(13.0)
                .navigationBarBackButtonHidden(true)
                if showText {
                    ZStack{
                        Color(red: 0, green: 0.151, blue: 0.195).ignoresSafeArea()
                        VStack{
                            Text("Game Over")
                                .padding()
                                .foregroundColor(.white)
                            let endString = "Score: " + String(score - 1)
                            Text(endString)
                                .padding()
                                .foregroundColor(.white)
                            HStack{
                                Button(action: {
                                    timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
                                    
                                    showText = false
                                    score = 0
                                    currBlock = [3,4,5]
                                    lastRowBlock = [3,4,5]
                                    currIndex = 0
                                    newCurrBlock = []
                                    fallOffSquares = []
                                    currDirection = "R"
                                    currRow = 8
                                    showText = false
                                    colors = [[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray],[.gray, .gray, .gray, .blue, .blue, .blue, .gray, .gray, .gray]]
                                }) {
                                    Text("Play Again")
                                        .foregroundColor(.blue)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.blue, lineWidth: 5)
                                        )
                                }
                                
                                
                                Button(action: {
                                }) {
                                    NavigationLink(destination: MainMenuView().navigationBarBackButtonHidden(true)) {
                                        Text("Main Menu")
                                            .foregroundColor(.blue)
                                            .padding()
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.blue, lineWidth: 5)
                                            )
                                        
                                    }
                                }
                                
                            }
                        }
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 300, height: 200)
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous).fill(Color(red: 0, green: 0.151, blue: 0.195)).shadow(radius: 3))
                    .navigationBarBackButtonHidden(true)
                    .zIndex(4)
                }
            }
        }
        
    }
    func forwardMove() -> Void {
        if currBlock.last ?? currBlock[0] < columns {
            currBlock.append((currBlock.last ?? currBlock[0])+1)
            currBlock.removeFirst()
            if currBlock.last! < columns {
                colors[currRow][currBlock[0]-1] = .gray
                colors[currRow][currBlock.last!] = .blue
            }
            AudioServicesPlaySystemSound(1057)
        }
        if currBlock.last! == columns {
            currDirection = "L"
            currBlock.insert(currBlock[0] - 1, at: 0)
            currBlock.removeLast()
            colors[currRow][currBlock.last!] = .gray
            colors[currRow][currBlock[0]] = .blue
            AudioServicesPlaySystemSound(1057)

        }
    }
    func backwardMove() -> Void {
        if currBlock[0] > -1 {
            currBlock.insert(currBlock[0]-1, at: 0)
            currBlock.removeLast()
            if currBlock[0] > -1 {
                colors[currRow][currBlock.last! + 1] = .gray
                colors[currRow][currBlock[0]] = .blue
                AudioServicesPlaySystemSound(1057)
            }
        }
        if currBlock[0] == -1 {
            currDirection = "R"
            currBlock.append(currBlock.last! + 1)
            currBlock.removeFirst()
            colors[currRow][currBlock[0]] = .gray
            currBlock.append(currBlock.last! + 1)
            currBlock.removeFirst()
            colors[currRow][currBlock.last!] = .blue
            AudioServicesPlaySystemSound(1057)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
