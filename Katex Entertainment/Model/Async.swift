//
//  Async.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/5/22.
//

import Foundation

enum Async<T> {
    case uninitialized
    case loading(progress: Int = 0, value: T? = nil)
    case success(value: T)
    case failed(error: Error, value: T? = nil)
}
