//
//  BookController.swift
//  Reading List
//
//  Created by Bling Morley on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        return booksURL
    }
    
    
    func saveToPersistentStore() {
       
        do {
            let encoder = PropertyListEncoder()
            let booksPList = try encoder.encode(books)
            guard let readingListURL = readingListURL else { return }
            try booksPList.write(to: readingListURL)
        } catch {
            print("Something went wrong saving info. \(error)")
        }
    }
    
    func loadToPersistentStore() {
        
        guard let readingListURL = readingListURL else { return }
        
        do {
            let decoder = PropertyListDecoder()
            let BooksPList = try Data(contentsOf: readingListURL)
            let decodedBooks = try decoder.decode([Book].self, from: BooksPList)
            self.books = decodedBooks
        } catch {
            print("There was an error loading your data \(error)")
        }
    }
    
    
}
