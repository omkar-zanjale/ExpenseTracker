//
//  AddTransactionView.swift
//  ExpenseTracker
//
//  Created by admin on 09/01/23.
//

import SwiftUI

struct AddTransactionView: View {
    
    @Binding var merchant: String
    
    var body: some View {
        ScrollView {
            VStack() {
                TextField("Merchant", text: $merchant)
                    .modifier(CustomTextFieldModifier(inputText: $merchant, placeHolder: ""))
            }.padding()
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(merchant: .constant(""))
    }
}
