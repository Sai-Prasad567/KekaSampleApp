//
//  Extensions.swift
//  KekaHRApp
//
//  Created by Sai Prasad on 07/11/24.
//

import Foundation

import UIKit

extension UIView {
    struct AnchoredConstraints {
        var top, leading, bottom, trailing, centerX, centerY, width, height: NSLayoutConstraint?
    }
    
    @discardableResult
    func addConstraint(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, width: NSLayoutDimension? = nil, height: NSLayoutDimension? = nil, padding: UIEdgeInsets = .zero,
                       size: CGSize = .zero, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil,
                       centerXOffset: CGFloat = 0, centerYOffset: CGFloat = 0) -> AnchoredConstraints {
        self.translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 && width == nil {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        } else if let width = width {
            anchoredConstraints.width = widthAnchor.constraint(equalTo: width)
        }
        
        if size.height != 0 && height == nil {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        } else if let height = height {
            anchoredConstraints.height = heightAnchor.constraint(equalTo: height)
        }
        
        if let centerX = centerX {
            anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: centerX, constant: centerXOffset)
        }
        
        if let centerY = centerY {
            anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: centerY, constant: centerYOffset)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing,
         anchoredConstraints.width, anchoredConstraints.height,
         anchoredConstraints.centerX, anchoredConstraints.centerY].forEach{ $0?.isActive = true }
      
        return anchoredConstraints
    }
}

extension UIImageView {
    
    func setImage(urlString: String) {
        let imageURL = URL(string: urlString)
        let data = try? Data(contentsOf: imageURL!)
        DispatchQueue.main.async {
            guard let data = data else { return }
            self.image = UIImage(data: data)
        }
    }
}

extension String {
    func formatDate(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = inputFormatter.date(from: dateString) else {
            return dateString // return original if parsing fails
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM yyyy" // "November 2024" format
        
        return outputFormatter.string(from: date)
    }
}
