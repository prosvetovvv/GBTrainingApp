//
//  ConvertDateService.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 16.11.2020.
//

import Foundation

struct ConvertDateService {
        
    func convertUnixTime(from date: Int64) -> String {
        let timeResult = Double(date)
        let date = Date(timeIntervalSince1970: timeResult)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        
        return localDate
    }
}
