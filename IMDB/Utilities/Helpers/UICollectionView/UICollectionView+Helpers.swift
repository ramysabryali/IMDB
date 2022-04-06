//
//  UICollectionView+Helpers.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 04/04/2022.
//

import UIKit

extension UICollectionView {
    func registerCellNib<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        let nibName = reuseIdentifier ?? T.classNameWithoutNamespaces
        self.register(T.loadNib(), forCellWithReuseIdentifier: nibName)
    }
    
    /// dequeue cell with generics
    func dequeue<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T
        else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
}
