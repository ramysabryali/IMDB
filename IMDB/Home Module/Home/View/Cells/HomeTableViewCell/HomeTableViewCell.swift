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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

private extension HomeTableViewCell {
    typealias CollectionViewdataSource = RxCollectionViewSectionedReloadDataSource
    
    //
    //        func setupTableVie2w() {
    //            collectionView.registerCellNib(MovieCollectionViewCell.self)
    //            let dataSource = createCollectionViewDataSource()
    //            movies
    //                .asObservable()
    //                .bind(to: collectionView.rx.items(dataSource: dataSource))
    //                .disposed(by: disposeBag)
    //        }
    
    func setupTableView() {
        collectionView.registerCellNib(MovieCollectionViewCell.self)
        //        let dataSource = createTableViewDataSource()
        
//        moviesSubject
//            .asObservable()
//            .bind(to: collectionView.rx.items) {
//                (tableView: UICollectionView, index: Int, element: [MovieData]) in
////                let indexPath = IndexPath(item: index, section: 0)
////                let cell: MovieCollectionViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! MovieCollectionViewCell
//
//                return UICollectionViewCell()
//            }
//            .disposed(by: disposeBag)
        
        moviesSubject
            .asObservable()
            .bind(to: collectionView.rx.items(
                cellIdentifier: "MovieCollectionViewCell",
                cellType: MovieCollectionViewCell.self
            )
            ) { row, data, cell in
                //                    cell.data = data
            }
            .disposed(by: disposeBag)
        
        collectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
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
}

extension HomeTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 30) / 3 // compute your cell width
        return CGSize(width: cellWidth, height: cellWidth / 0.6)
    }
}
