//
//  DataFetchPhase.swift
//  MovieDevRev
//
//  Created by Anubhav Singh on 18/02/24.
//

import Foundation

enum DataFetchPhase<V> {
    
    case empty
    case success(V)
    case failure(Error)
    
    var value: V? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
}

