//
//  DeeplinkHandlerProtocol.swift
//  TasksApp
//
//  Created by user on 30.05.2024.
//

import Foundation

protocol DeeplinkHandlerProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func openURL(_ url: URL)
}
