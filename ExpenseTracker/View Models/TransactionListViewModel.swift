//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by admin on 28/12/22.
//

import Foundation
import Combine
import OrderedCollections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]


class TransactionListViewModel: ObservableObject {
    
    @Published var transactionList = [Transaction]()
    @Published var currentUser: UserData?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactionList()
    }
    
    func getTransactionList() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { complition in
                switch complition {
                case .failure(let error):
                    print("Error while decoding Transactions: ",error.localizedDescription)
                case .finished:
                    print("Decoding transaction finished.")
                }
            } receiveValue: { [weak self]result in
                self?.transactionList = result
                dump(self?.transactionList)
            }
            .store(in: &cancellables)
    }
    
    func getGroupTransactionsByMonth() -> TransactionGroup {
        guard !transactionList.isEmpty else {return [:]}
        let groupedTransactions = TransactionGroup(grouping: transactionList) { $0.month }
        return groupedTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactionList.isEmpty else { return [] }
        let todayDate = "02/17/2022".parsedDate() //Todays date Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: todayDate)!
        print("Date Interval",dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        let arrayOfDates = stride(from: dateInterval.start, to: todayDate, by: 60 * 60 * 24)
        
        for date in arrayOfDates {
            let dailyExpenses = transactionList.filter({ $0.parsedDate == date && $0.isExpense })
            let dailyTotal = dailyExpenses.reduce(0) {$0 - $1.signedAmount}
            
            sum += dailyTotal
            sum = sum.rounded()
//            let calendarDate = Calendar.current.dateComponents([.day], from: date)
//            let day = Double(calendarDate.day!)
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "Daily total: ", dailyTotal, "sum", sum)
            
        }
        return cumulativeSum
    }
}
