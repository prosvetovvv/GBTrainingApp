//
//  CoreDateNewsService.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 06.11.2020.
//

import Foundation
import CoreData

class CoreDataNewsService {
    
    static let shared = CoreDataNewsService()
    let storeStack    = CoreDataStack.shared
    
    
    private init() {}
    
    
    func saveNews(from arrayNews: [New]) {
        let context = storeStack.context
        
        for new in arrayNews {
            let news = News(context: context)
            
            news.sourceId = new.sourceId
            news.date = new.date
            news.text = new.text
            news.likes = new.likes?.count ?? 0
            news.comments = new.comments?.count ?? 0
            news.reposts = new.reposts?.count ?? 0
            news.show = new.views?.count ?? 0
        }
        storeStack.saveContext()
    }
    
    
    func clearNews() {
        let context = storeStack.context
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        do {
            let object = try context.fetch(fetchRequest)
            _ = object.map{context.delete($0)}
            storeStack.saveContext()
        } catch let error {
            print(error)
        }
    }
}

