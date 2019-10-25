//
//  File.swift
//  
//
//  Created by Jan Rajtr on 25/10/2019.
//

infix operator >=>: AdditionPrecedence

/// This operator chains asynchronous operations.
/// - Parameter f: first function
/// - Parameter g: second function
public func chain <T, U, V> (f: @escaping Request<T, Result<U>>, g: @escaping Request<U, Result<V>>) -> Request<T, Result<V>> {
    return { (input, combineCompletion) in
        
        f(input) { (u: Result<U>) in
            switch u {
            case .success(let unwrappedU): g(unwrappedU) { (v: Result<V>) in combineCompletion(v) }
            case .failure(let error): combineCompletion(.failure(error))
            }
        }
    }
}
