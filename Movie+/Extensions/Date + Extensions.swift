//
//  Date + Extensions.swift
//  Movie+
//
//  Created by Ikmal Azman on 03/07/2023.
//

import Foundation

extension Date {
    var toMonthDayTimeFormat : String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "MMM d, h:mm a"
        let date = dataFormatter.string(from: self)
        return date
    }
}
