//
//  Path+Format.swift
//  SimplePath
//
//  Copyright (c) 2017 Ramon Torres
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

public enum PathElements {
    /// A directory. e.g. "/var/home"
    case dir

    /// basename
    case base

    /// File extension. e.g. "txt"
    case ext
}

// -------------------------------------------------------
//  MARK: - Format
// -------------------------------------------------------

extension Path {

    /// Builds a path, given named elements of a path.
    ///
    /// - parameter elements:  A dictionary of named elements and their values.
    ///
    /// - returns:  A path built from the given elements.
    public static func format(_ elements: [PathElements: String?]) -> String {
        var path = ""

        if let dir = elements[.dir] as? String {
            path = dir
        }

        if let base = elements[.base] as? String {
            path = self.join([path, base])
        }

        if let ext = elements[.ext] as? String {
            if !ext.hasPrefix("/") {
                path.append(".\(ext)")
            }
        }

        return path
    }

}
