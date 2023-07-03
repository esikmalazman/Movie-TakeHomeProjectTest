//
//  EmptyState.swift
//  Movie+
//
//  Created by Ikmal Azman on 01/07/2023.
//

import UIKit

enum EmptyStateKind {
    case search
    case recents
    case favourites
}

extension EmptyStateKind {
    var messsage : String {
        switch self {
        case .search:
            return "This is where you'll see the movie you are looking for"
        case .recents:
           return "Oops! It seems like there are no recent searches to display."
        case .favourites:
            return "Uh-oh, your favorite movie list is feeling a bit lonely"
        }
    }
    
    var imageName : String {
        switch self {
        case .search:
            return "magnifyingglass"
        case .recents:
            return "clock.arrow.circlepath"
        case .favourites:
            return "bookmark.fill"
        }
    }
}

final class EmptyState: UIViewController {
   

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.tintColor = .black.withAlphaComponent(0.5)
    }
    
    func setup(for kind : EmptyStateKind) {
    
        messageLabel.text = kind.messsage
        imageView.image = UIImage(systemName: kind.imageName)
    }
    
    func layout(in parentView : UIView) {
        parentView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: 360)
        ])
    }
}

