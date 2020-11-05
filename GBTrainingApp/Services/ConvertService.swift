//
//  ConvertService.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 05.11.2020.
//

import Foundation

struct ConvertService {
    
    static let shared = ConvertService()
    
    private init() {}
    
    func convertUnixTimeToDate(from jsonResult: Int64) -> String {
        let timeResult = Double(jsonResult)
        let date = Date(timeIntervalSince1970: timeResult)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        
        return localDate
    }
}
