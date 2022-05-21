//
//  LocalStorageManager.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 20.05.22.
//

import Foundation

class LocalStorageManager: FileManager {
    
    static let shared = LocalStorageManager()
    
    private (set) var documentsDirectoryURL: URL
    private (set) var userId: String = ""
    
    private override init() {
//        super.init()
        documentsDirectoryURL = LocalStorageManager.getLocalPath()
    }
    
    func setUserDir(userId: String) {
        self.userId = userId.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func updateLocalPath() {
        documentsDirectoryURL = LocalStorageManager.getLocalPath()
        print(documentsDirectoryURL)
    }
    
    static func getLocalPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func deleteFileIfExists(path: String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            do {
                print("Deleting file \(path)")
                try FileManager.default.removeItem(atPath: path)
                return true
            } catch let error {
                print(error.localizedDescription)
                return false
            }
        } else {
            return true
        }
    }
    
    func isFileExist(url: URL) -> Bool {
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    func isMediaExist(mediumId: String, folder: String) -> URL? {
        if let url = getFileURL(itemId: mediumId, folder: folder) {
            if FileManager.default.fileExists(atPath: url.path) {
                return url
            }
        }
        return nil
    }
    
    func getFileURL(itemId: String, folder: String, createDirectory: Bool = true) -> URL? {
        let url = documentsDirectoryURL
            .appendingPathComponent(getUserDir())
            .appendingPathComponent(folder)
        
        if createDirectory {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch (let error) {
                print(error)
                return nil
            }
        }
        return url
            .appendingPathComponent("media_\(itemId)")
            .appendingPathExtension("mp3")
    }
    
    func getUserDir() -> String {
        return "user." + userId
    }
    
    /// Delete all files in user's document directory
    func deleteAll() {
        do {
            try FileManager.default.removeItem(at: documentsDirectoryURL)
        } catch {
            
        }
    }
    
    func deleteUserFolders() {
//        print(getSubDirectories())
        guard let directories = getSubDirectories() else { return }
        
        for path in directories {
            if path.lastPathComponent.contains("user.") {
                print(path)
                do {
                    try FileManager.default.removeItem(at: path)
                } catch {
                    
                }
            }
        }
    }
    
    func getSubDirectories(url: URL? = nil) -> [URL]? {
        let url = url ?? documentsDirectoryURL
        // @available(macOS 10.11, iOS 9.0, *)
        guard documentsDirectoryURL.hasDirectoryPath else { return [] }
        do {
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]).filter(\.hasDirectoryPath)
        } catch {
            
        }
        return nil
    }
    
    func saveDataToFile(data: Data, saveTo: URL) {
        do {
            print("Saving to \(saveTo)")
//            FileManager.default.createFile(atPath: saveTo.path, contents: data, attributes: nil)
            try data.write(to: saveTo, options: [.noFileProtection])
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
}
