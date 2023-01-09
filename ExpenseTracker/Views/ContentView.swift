//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by admin on 28/12/22.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
  
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    @State var isLogoutClicked: Bool = false
    @State var isNotificationsClicked: Bool = false
    @State var isProfileClicked: Bool = false
    
    var body: some View {
        self.updateNavigationBarColor()
        return ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                //MARK: Title
                Text("Overview")
                    .font(.title2)
                    .bold()
                
                //MARK: Chart
                let chartData = transactionListVM.accumulateTransactions()
                if !chartData.isEmpty {
                    let totalExpense = chartData.last?.1 ?? 0
                    CardView {
                        VStack(alignment: .leading) {
                            ChartLabel(totalExpense.formatted(.currency(code: "USD")),type: .title, format: "$%.02f")
                            LineChart()
                        }
                        .background(Color.systemBackground)
                    }
                    .data(chartData)
                    .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.2), Color.icon)))
                    .frame(height: 300)
                }
                
                //MARK: Transactions
                RecentTransactionView()
            }
            .padding()
            .frame(maxWidth: .infinity)
            NavigationLink(destination: ProfileView(), isActive: $isProfileClicked){}
        }
        .background(Color.background)
        .navigationBarBackButtonHidden(true)
        .modifier(NavigationBarModifier(isLogoutClicked: $isLogoutClicked, isNotificationsClicked: $isNotificationsClicked, isProfileClicked: $isProfileClicked))
    }
    
    func updateNavigationBarColor() {
        if isLogoutClicked {
            UserDefaults.standard.set(false, forKey: UserDefaultKeys.isFingerActivated.rawValue)
            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.currentUserName.rawValue)
            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.currentUserPassword.rawValue)
            Constant.signUpFromFinger = false
            self.mode.wrappedValue.dismiss()
            self.isLogoutClicked = false
        }
        UINavigationBar.appearance().barTintColor = UIColor(Color.background)
        UINavigationBar.appearance().backgroundColor = UIColor(Color.background)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TransactionListViewModel())
    }
}
