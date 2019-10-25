//
//  File.swift
//  
//
//  Created by Jan Rajtr on 25/10/2019.
//

import Foundation

infix operator >=>: AdditionPrecedence
public typealias RequestCompletion<ResponseType> = (ResponseType) -> Void
public typealias Request<T, U> = (T, @escaping RequestCompletion<U>) -> Void

/// This operator chains asynchronous operations in so-called Kleisli composition.
/// - Parameter f: first function
/// - Parameter g: second function
public func >=> <T, U, V> (f: @escaping Request<T, Result<U,Error>>, g: @escaping Request<U, Result<V,Error>>) -> Request<T, Result<V,Error>> {
    return { (input, combineCompletion) in
        
        f(input) { (u: Result<U,Error>) in
            switch u {
            case .success(let unwrappedU): g(unwrappedU) { (v: Result<V,Error>) in combineCompletion(v) }
            case .failure(let error): combineCompletion(.failure(error))
            }
        }
    }
}
