//
//  Path.swift
//  SimplePath
//
//  Created by Ramon Torres on 10/22/17.
//  Copyright © 2017 Ramon Torres. All rights reserved.
//

import Foundation

enum PathElements {
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

struct Path {

    /// Builds a path string by joining components, adding directory
    /// separators where necessary.
    ///
    /// - parameter components:  Path components.
    ///
    /// - returns:  Path built from components.
    static func join(_ components: [String]) -> String{
        return NSString.path(withComponents: components)
    }

    /// Returns all components of a given path.
    ///
    /// - parameter path:  The path to be split into components.
    ///
    /// - returns:  Path components.
    static func split(_ path: String) -> [String] {
        return NSString(string: path).pathComponents
    }

    /// Returns the last component of a path.
    ///
    /// - parameter path:  A path.
    /// - parameter ext:   A file extension (ie: "txt"). If the last component
    ///                    ends with this extension, it will be removed.
    ///
    /// - returns:  The last component (base name) of the given path.
    static func basename(_ path: String, ext: String? = nil) -> String {
        let base = NSString(string: path).lastPathComponent

        guard let `extension` = ext else {
            return base
        }

        guard extname(base) == `extension` else {
            return base
        }

        return NSString(string: base).deletingPathExtension
    }

    /// Returns the parent directory of a path.
    ///
    /// - parameter path:  A path.
    ///
    /// - returns:  Parent directory.
    static func dirname(_ path: String) -> String {
        return NSString(string: path).deletingLastPathComponent
    }

    /// Returns the extension of a path.
    ///
    /// - parameter path:  A path.
    ///
    /// - returns:  Extension name (without period).
    static func extname(_ path: String) -> String? {
        let ext = NSString(string: path).pathExtension

        if ext.isEmpty {
            return nil
        }

        return ext
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
    static func format(_ elements: [PathElements: String?]) -> String {
        var path = ""

        if let dir = elements[.dir] as? String {
            path = dir
        }

        if let base = elements[.base] as? String {
            path = self.join([path, base])
        }

        if let ext = elements[.ext] as? String {
            if let pathWithExtension = NSString(string: path).appendingPathExtension(ext) {
                path = pathWithExtension
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
    static func isAbsolute(_ path: String) -> Bool {
        return NSString(string: path).isAbsolutePath
    }

    /// Returns `true` if the given path is relative.
    ///
    /// - parameter path:  A path
    ///
    /// - returns:  `true` if the path is relative.
    static func isRelative(_ path: String) -> Bool {
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
    static func exists(_ path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }

    /// Checks whether a path is a directory.
    ///
    /// - parameter path:  A path
    ///
    /// - returns:  `true` if the path exists and is a directory, `false` otherwise.
    static func isDir(_ path: String) -> Bool {
        var dir: ObjCBool = false

        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &dir)

        return exists && dir.boolValue
    }

}
