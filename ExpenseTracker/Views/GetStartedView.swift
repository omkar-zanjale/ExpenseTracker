//
//  GetStartedView.swift
//  ExpenseTracker
//
//  Created by admin on 30/12/22.
//

import SwiftUI

struct GetStartedView: View {
    
    @State var isStartedClicked = false

    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack {
                Text("Welcome")
                    .font(.system(size: 50))
                    .bold()
                    .shadow(color: .yellow, radius: 1)
                    .foregroundColor(.green)
                
                GIFView(fileName: "money")
                    .frame(height: 400)
                    .background(Color.background)
                    .padding()
                
                Button {
                    UserDefaults.standard.set(true, forKey: UserDefaultKeys.isNotFirstLaunch.rawValue)
                    isStartedClicked = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(.green, lineWidth: 4)
                            .frame(height: 60)
                            .padding()
                        Text("Get Started")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(.green)
                    }
                }
                NavigationLink(destination: SignInView(), isActive: $isStartedClicked) {}
            }
            .padding()
        }
    }
}

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
