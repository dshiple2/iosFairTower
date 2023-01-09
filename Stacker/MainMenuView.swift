//
//  MainMenuView.swift
//  Stacker
//
//  Created by David Shipley on 1/8/23.
//

import SwiftUI

struct MainMenuView: View {
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
                    .fill(Color(red: 0, green: 0.151, blue: 0.195))
                    .frame(height: 450)
                    .frame(width: 100)
                    .zIndex(2)
                VStack {
                    Text("Fair Tower")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(25)
                        .foregroundColor(.white)
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        Text("Play")
                    }
                    .foregroundColor(.blue)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 5)
                    )
                }
                .zIndex(3)
                .navigationBarBackButtonHidden(true)
            }
        }
        }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
