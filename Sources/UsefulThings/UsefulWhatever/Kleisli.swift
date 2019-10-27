//
//  File.swift
//  
//
//  Created by Jan Rajtr on 25/10/2019.
//

import Foundation

infix operator >=>: AdditionPrecedence
public typealias KleisliRequestCompletion<ResponseType> = (ResponseType) -> Void
public typealias KleisliRequest<T, U> = (T, @escaping KleisliRequestCompletion<U>) -> Void

/// This operator chains asynchronous operations in so-called Kleisli composition.
/// - Parameter f: first function
/// - Parameter g: second function
public func >=> <T, U, V> (f: @escaping KleisliRequest<T, Result<U,Error>>, g: @escaping KleisliRequest<U, Result<V,Error>>) -> KleisliRequest<T, Result<V,Error>> {
    return { (input, combineCompletion) in
        
        f(input) { (u: Result<U,Error>) in
            switch u {
            case .success(let unwrappedU): g(unwrappedU) { (v: Result<V,Error>) in combineCompletion(v) }
            case .failure(let error): combineCompletion(.failure(error))
            }
        }
    }
}
