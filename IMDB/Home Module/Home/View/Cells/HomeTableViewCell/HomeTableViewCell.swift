//
//  HomeTableViewCell.swift
//  IMDB
//
//  Created by Ramy Sabry on 15/04/2022.
//

import UIKit
import RxSwift
import RxDataSources

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var disposeBag = DisposeBag()
    var moviesSubject = PublishSubject<[MovieData]>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Private Methods

private extension HomeTableViewCell {
    typealias CollectionViewdataSource = RxCollectionViewSectionedReloadDataSource

    func setupCollectionView() {
        collectionView.registerCellNib(MovieCollectionViewCell.self)
  
        collectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        moviesSubject
            .asObservable()
            .bind(to: collectionView.rx.items(
                cellIdentifier: MovieCollectionViewCell.classNameWithoutNamespaces,
                cellType: MovieCollectionViewCell.self
            )
            ) { row, data, cell in
                cell.titleLabel.text = data.title
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDelegate

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let cellWidth = (width - 15) / 2.5
        return CGSize(width: cellWidth, height: collectionView.frame.height)
    }
}
