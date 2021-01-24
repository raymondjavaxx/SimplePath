//
//  Path+Utils.swift
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

// -------------------------------------------------------
// MARK: - Utils
// -------------------------------------------------------

extension Path {

    /// Checks whether a path (file or directory) exists.
    ///
    /// - parameter path:  A path
    ///
    /// - returns:  `true` if the path exists, `false` otherwise.
    public static func exists(_ path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }

    /// Checks whether a path is a regular file.
    ///
    /// - parameter path:  A path
    ///
    /// - returns:  `true` if the path exists and is a regular file, `false` otherwise.
    public static func isFile(_ path: String) -> Bool {
        var dir = ObjCBool(false)

        guard FileManager.default.fileExists(atPath: path, isDirectory: &dir) else {
            return false
        }

        return !dir.boolValue
    }

    /// Checks whether a path is a directory.
    ///
    /// - parameter path:  A path
    ///
    /// - returns:  `true` if the path exists and is a directory, `false` otherwise.
    public static func isDir(_ path: String) -> Bool {
        var dir = ObjCBool(false)

        guard FileManager.default.fileExists(atPath: path, isDirectory: &dir) else {
            return false
        }

        return dir.boolValue
    }

}
