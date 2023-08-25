//
//  Utilities.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 26.08.2023.
//

import Foundation

func getDateFormatted(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM 'at' HH:mm"
    
    return dateFormatter.string(from: date)
}
