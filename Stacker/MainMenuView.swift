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
                    Image("MenuScreen")
                        .resizable()
                          .frame(width: 300, height: 300)
                          .padding()
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        Image("PlayButton")
                            .resizable()
                            .frame(width: 154.68, height: 100)
                    }
                    .foregroundColor(.blue)
                    .padding()

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
