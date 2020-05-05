//
//  PersistenceHelper.swift
//  PhotoJournal
//
//  Created by Yuliia Engman on 5/1/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation

enum DataPersistenceError: Error { // conforming to the Error protocol
  case savingError(Error) // associative value
  case fileDoesNotExist(String)
  case noData
  case decodingError(Error)
  case deletingError(Error)
}

class PersistenceHelper {
  
  // CRUD - create, read, update, delete
  
  // array of entries
  private var events = [ImageObject]()
  
  private var filename: String
  
  init(filename: String) {
    self.filename = filename
  }
  
  private func save() throws {
    // step 1.
     // get url path to the file that the Entry will be saved to
     let url = FileManager.pathToDocumentsDirectory(with: filename)
    
    // entries array will be object being converted to Data
    // we will use the Data object and write (save) it to documents directory
    do {
      // step 3.
      // convert (serialize) the journalEntries array to Data
      let data = try PropertyListEncoder().encode(events)
      
      // step 4.
      // writes, saves, persist the data to the documents directory
      try data.write(to: url, options: .atomic)
    } catch {
      // step 5.
      throw DataPersistenceError.savingError(error)
    }
  }
  
  // for re-ordering
  public func reorderEvents(events: [ImageObject]) {
    self.events = events
    try? save()
  }
  
  // DRY - don't repeat yourself
  
  // create - save item to documents directory
  public func create(event: ImageObject) throws {
    // step 2.
    // append new entry to the entry array
    events.append(event)
    
    do {
      try save()
    } catch {
      throw DataPersistenceError.savingError(error)
    }
  }

  // read - load (retrieve) items from documents directory
  public func loadEvents() throws -> [ImageObject] {
    // we need access to the filename URL that we are reading from
    let url = FileManager.pathToDocumentsDirectory(with: filename)
    
    // check if file exist
    // to convert URL to String we use .path on the URL
    if FileManager.default.fileExists(atPath: url.path) {
      if let data = FileManager.default.contents(atPath: url.path) {
        do {
          events = try PropertyListDecoder().decode([ImageObject].self, from: data)
        } catch {
          throw DataPersistenceError.decodingError(error)
        }
      } else {
        throw DataPersistenceError.noData
      }
    }
    else {
      throw DataPersistenceError.fileDoesNotExist(filename)
    }
    return events
  }
  
  // delete - remove item from documents directory
  public func delete(event index: Int) throws {
    // remove the item from the entry array
    events.remove(at: index)
    
    // save our entry array to the documents directory
    do {
      try save()
    } catch {
      throw DataPersistenceError.deletingError(error)
    }
  }
    
    // Update
    
    @discardableResult // Silences the warning if the return value is not used by the caller
    public func update(_ oldEvent: ImageObject, with newEvent: ImageObject) -> Bool  {
        // find index of the oldItem and replace it with the newItem
        if let index = events.firstIndex(of: oldEvent) {
            
            let result = update(newEvent, at: index)
            return result
        }
        return false
    }
    
    @discardableResult // Silences the warning if the return value is noy used by the caller
    public func update(_ item: ImageObject, at index: Int) -> Bool {
        events[index] = item
        // save to doc directory
        
        do {
            try save()
            return true
        } catch {
            return false
        }
    }
}
