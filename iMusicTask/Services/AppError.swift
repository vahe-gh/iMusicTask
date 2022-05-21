//
//  AppError.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 18.05.22.
//

import Foundation

enum AppError: Error {
    case cantGenerateURL
    case invalidURL
    case unknownError
    case fileNotExist
    case cantDeleteFile
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cantGenerateURL:
            return "Can't generate URL."
        case .invalidURL:
            return "URL is invalid."
        case .unknownError:
            return "Unknown error, please contact support."
        case .fileNotExist:
            return "File does not exist."
        case .cantDeleteFile:
            return "Can't delete file."
        }
    }
}
