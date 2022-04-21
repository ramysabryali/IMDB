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
    var movies = PublishSubject<[MovieData]>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//private extension HomeTableViewCell {
//    typealias CollectionViewdataSource = RxCollectionViewSectionedReloadDataSource
//    
//    func setupTableView() {
//        collectionView.registerCellNib(MovieCollectionViewCell.self)
//        let dataSource = createCollectionViewDataSource()
//        movies
//            .asObservable()
//            .bind(to: collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
//    }
//    
//    func createCollectionViewDataSource() -> CollectionViewdataSource<MovieData> {
//        return CollectionViewdataSource<MovieData>(configureCell: { dataSource, collectionView, indexPath, item -> UICollectionViewCell in
//            
//            let cell:MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
//            
//            cell.backgroundColor = UIColor.green
//            
//            return cell
//        })
//    }
//}
