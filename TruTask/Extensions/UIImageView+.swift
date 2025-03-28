//
//  UIImageView+.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import UIKit

extension UIImageView {
    func loadImage(from url: String) async {
        guard let url = URL(string: url) else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        } catch {
           
        }
    }
}
