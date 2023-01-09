//
//  RecentTransactionView.swift
//  ExpenseTracker
//
//  Created by admin on 28/12/22.
//

import SwiftUI

struct RecentTransactionView: View {

    @EnvironmentObject var transactionListVM: TransactionListViewModel
    var body: some View {
        VStack {
            HStack {
                //MARK: Title
                Text("Recent Transactions")
                    .bold()
                Spacer()
                //MARK: See all
                NavigationLink {
                    TransactionListView()
                } label: {
                    HStack(spacing: 4) {
                        Text("See all")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
                
            }
            .padding(.top)
            
            ForEach(Array(transactionListVM.transactionList.prefix(5).enumerated()), id: \.element) { index, transaction in
                TransactionRowView(transaction: transaction)
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionView_Previews: PreviewProvider {
   
    static var previews: some View {
        NavigationView {
            RecentTransactionView()
                .environmentObject(TransactionListViewModel())
        }
    }
}
