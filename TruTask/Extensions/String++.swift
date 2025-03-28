//
//  String++.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

extension String {
    func fetchData() async throws -> Data {
        guard let url = URL(string: self) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
