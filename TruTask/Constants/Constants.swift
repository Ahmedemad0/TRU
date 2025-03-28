//
//  Constants.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

enum Constants {
    static let baseURL: URL = {
        guard let url = URL(string: "https://fakestoreapi.com") else {
            preconditionFailure("Invalid URL")
        }
        return url
    }()
}
