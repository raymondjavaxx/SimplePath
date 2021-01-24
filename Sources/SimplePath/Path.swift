//
//  Path.swift
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
//  MARK: - Basics
// -------------------------------------------------------

public struct Path {

    public static let separator = "/"

    /// Builds a path string by joining components, adding directory
    /// separators where necessary.
    ///
    /// - parameter components:  Path components.
    ///
    /// - returns:  Path built from components.
    public static func join(_ components: [String]) -> String {
        var result: String = ""

        if let root = components.first {
            result.append(root)
        }

        let firstIndex = components.index(after: components.startIndex)

        let range = firstIndex..<components.endIndex

        for comp in components[range] {
            var componentStart = comp.startIndex

            if result.count > 0 && comp.hasPrefix("/") {
                componentStart = comp.index(after: componentStart)
            }

            if comp.distance(from: componentStart, to: comp.endIndex) > 0 {
                if result.count > 0 && !result.hasSuffix("/") {
                    result.append("/")
                }

                result.append(String(comp[componentStart..<comp.endIndex]))
            }
        }

        return result
    }

    /// Returns all components of a given path.
    ///
    /// - parameter path:  The path to be split into components.
    ///
    /// - returns:  Path components.
    public static func split(_ path: String) -> [String] {
        var result = [String]()

        if (path.hasPrefix("/")) {
            result.append("/")
        }

        let components = path.split(separator: "/").map { String($0) }
        result.append(contentsOf: components)

        if (path.count > 1 && path.hasSuffix("/")) {
            result.append("/")
        }

        return result
    }

    /// Returns the last component of a path.
    ///
    /// - parameter path:  A path.
    /// - parameter ext:   A file extension (ie: "txt"). If the last component
    ///                    ends with this extension, it will be removed.
    ///
    /// - returns:  The last component (base name) of the given path.
    public static func basename(_ path: String, ext: String? = nil) -> String {
        let base = self.lastPathComponent(path)

        guard let `extension` = ext else {
            return base
        }

        guard self.extname(base) == `extension` else {
            return base
        }

        return self.deletePathExtension(base)
    }

    /// Returns the parent directory of a path.
    ///
    /// - parameter path:  A path.
    ///
    /// - returns:  Parent directory.
    public static func dirname(_ path: String) -> String {
        guard let range = path.range(of: "/", options: .backwards) else {
            return "";
        }

        let dir = String(path.prefix(upTo: range.lowerBound))

        return dir.count == 0 ? "/" : dir
    }

    /// Returns the extension of a path.
    ///
    /// - parameter path:  A path.
    ///
    /// - returns:  Extension name (without period).
    public static func extname(_ path: String) -> String? {
        let filename = self.lastPathComponent(path)

        guard let range = filename.range(of: ".", options: .backwards) else {
            return nil;
        }

        let index = filename.index(after: range.lowerBound)

        let ext = String(filename.suffix(from: index))

        return ext.isEmpty ? nil : ext
    }

}

// -------------------------------------------------------
//  MARK: - Internal utils
// -------------------------------------------------------

extension Path {

    fileprivate static func deletePathExtension(_ path: String) -> String {
        if (path.count <= 1) {
            return path
        }

        var result = path

        if result.hasSuffix("/") {
            result = String(result.prefix(upTo: result.endIndex))
        }

        if let index = self.beginingOfPathExtension(result) {
            result = String(result.prefix(upTo: index))
        }

        return result
    }

    fileprivate static func beginingOfPathExtension(_ path: String) -> String.Index? {
        var beginingOfLastComponent = path.startIndex

        if let range = path.range(of: "/", options: .backwards) {
            beginingOfLastComponent = range.lowerBound
        }

        var currentPosition = path.index(before: path.endIndex)

        while currentPosition > beginingOfLastComponent {
            if path[currentPosition] == "." {
                return currentPosition
            }

            currentPosition = path.index(before: currentPosition)
        }

        return nil
    }

    fileprivate static func lastPathComponent(_ path: String) -> String {
        guard let range = path.range(of: "/", options: .backwards) else {
            return path;
        }

        let index = path.index(after: range.lowerBound)
        return String(path.suffix(from: index))
    }

}

// -------------------------------------------------------
//  MARK: - Absolute + Relative
// -------------------------------------------------------

extension Path {

    /// Returns `true` if the path is an absolute path.
    ///
    /// - parameter path:  A path
    ///
    /// - returns:  `true` if the path is absolute.
    public static func isAbsolute(_ path: String) -> Bool {
        return path.hasPrefix("/") || path.hasPrefix("~")
    }

    /// Returns `true` if the given path is relative.
    ///
    /// - parameter path:  A path
    ///
    /// - returns:  `true` if the path is relative.
    public static func isRelative(_ path: String) -> Bool {
        return isAbsolute(path) == false
    }

}
