//
//  HomeViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 11/04/2022.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class HomeViewController: BaseViewController, LoadingDisplayerProtocol {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = HomeViewModel()
    weak var coordinator: TabbarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindLoadingIndicator(to: viewModel.stateRelay)
        setupTableView()
        viewModel.fetchAllMoviesData()
    }
}

private extension HomeViewController {
    typealias TableViewdataSource = RxTableViewSectionedReloadDataSource
    
    func setupTableView() {
        tableView.registerCellNib(HomeTableViewCell.self)
        let dataSource = createTableViewDataSource()
        viewModel
            .sections
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func createTableViewDataSource() -> TableViewdataSource<HomeSectionRowItem> {
        return TableViewdataSource<HomeSectionRowItem>(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            
            let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            
            cell.collectionView.backgroundColor = UIColor.blue
            
            if let itemData = try? dataSource.model(at: indexPath) as? HomeSectionRowItem {
                print("of a7")
                print("of a7")
//                cell.moviesSubject.bind(to: <#T##[MovieData]...##[MovieData]#>)
            }
            
            return cell
        }, titleForHeaderInSection: { dataSource, index in
            return dataSource.sectionModels[index].type.title
        })
    }
}
