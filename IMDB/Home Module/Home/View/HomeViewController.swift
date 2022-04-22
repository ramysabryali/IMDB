//
//  HomeViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 11/04/2022.
//

import UIKit
import RxCocoa
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

// MARK: - Private Methods

private extension HomeViewController {
    typealias TableViewdataSource = RxTableViewSectionedReloadDataSource
    
    func setupTableView() {
        tableView.registerCellNib(HomeTableViewCell.self)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        let dataSource = createTableViewDataSource()
        viewModel
            .sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func createTableViewDataSource() -> TableViewdataSource<HomeSectionRowItem> {
        return TableViewdataSource<HomeSectionRowItem>(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            
            let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            
            cell.collectionView.backgroundColor = UIColor.blue
            
            item.moviesSubject
                .bind(to: cell.moviesSubject)
                .disposed(by: self.disposeBag)

            return cell
        }, titleForHeaderInSection: { dataSource, index in
            return dataSource.sectionModels[index].items.first?.movieGroupType.title
        })
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
