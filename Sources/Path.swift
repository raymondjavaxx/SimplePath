//
//  Path.swift
//  SimplePath
//
//  Created by Ramon Torres on 10/22/17.
//  Copyright © 2017 Ramon Torres. All rights reserved.
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
//  MARK: - Basics
// -------------------------------------------------------

public struct Path {

    let separator = "/"

    /// Builds a path string by joining components, adding directory
    /// separators where necessary.
    ///
    /// - parameter components:  Path components.
    ///
    /// - returns:  Path built from components.
    public static func join(_ components: [String]) -> String {
        var cleanComponents = [String]()

        for (index, comp) in components.enumerated() {
            if index == 0 && comp == "/" {
                cleanComponents.append("")
            } else {
                if comp != "/" && comp.count > 0 {
                    var start = comp.startIndex
                    var end   = comp.endIndex

                    if comp.hasPrefix("/") {
                        start = comp.index(after: start)
                    }

                    if comp.hasSuffix("/") {
                        end = comp.index(before: end)
                    }

                    if comp.distance(from: start, to: end) > 0 {
                        cleanComponents.append("\(comp[start..<end])")
                    }
                }
            }
        }

        return cleanComponents.joined(separator: "/")
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

// -------------------------------------------------------
//  MARK: - Utils
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

#if os(Linux)
        return dir
#else
        return dir.boolValue
#endif
    }

}
