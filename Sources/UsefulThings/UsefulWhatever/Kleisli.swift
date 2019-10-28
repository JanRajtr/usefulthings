//
//  File.swift
//  
//
//  Created by Jan Rajtr on 25/10/2019.
//

import Foundation

infix operator >>->>: AdditionPrecedence
public typealias KleisliRequestCompletion<T> = (Result<T,Error>) -> Void
public typealias KleisliRequest<T, U> = (T, @escaping KleisliRequestCompletion<U>) -> Void

/// This operator chains asynchronous operations in so-called Kleisli composition.
/// - Parameter f: first function
/// - Parameter g: second function
/// - See Also: https://github.com/typelift/Operadics
/// <A, B, C>(A -> F<B>, B -> F<C>) -> A -> F<C>
public func >>->> <T, U, V> (f: @escaping KleisliRequest<T, U>,
                             g: @escaping KleisliRequest<U, V>) -> KleisliRequest<T, V> {
    return { (input, combineCompletion) in
        
        f(input) { (u: Result<U,Error>) in
            switch u {
            case .success(let unwrappedU):
                g(unwrappedU) { (v: Result<V,Error>) in
                    combineCompletion(v)
                }
            case .failure(let error):
                combineCompletion(.failure(error))
            }
        }
    }
}
