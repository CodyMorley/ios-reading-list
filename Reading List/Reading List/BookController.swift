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
    
    var readBooks: [Book] {
        var finishedBooks: [Book] = []
        for book in books {
            if book.hasBeenRead == true {
                finishedBooks.append(book)
            }
        }
        return finishedBooks
    }
    
    var unreadBooks: [Book] {
        var unfinishedBooks: [Book] = []
        for book in books {
            if book.hasBeenRead == false {
                unfinishedBooks.append(book)
            }
        }
        return unfinishedBooks
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        return booksURL
    }
    
    func createNewBook(title: String, reasonToRead: String) {
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        books.append(newBook)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
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
    
    func updateHasBeenRead(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        
        if books[bookIndex].hasBeenRead == true {
            books[bookIndex].hasBeenRead = false
        } else if books[bookIndex].hasBeenRead == false {
                books[bookIndex].hasBeenRead = true
        }
    }
    // TO DO: - Write this function's code block
    func updateBookStringValues(for book: Book) {
        
    }
}
