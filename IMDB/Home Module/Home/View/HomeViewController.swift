//
//  HomeViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 11/04/2022.
//

import UIKit
import RxCocoa
import RxDataSources

class HomeViewController: BaseViewController, LoadingDisplayerProtocol, AlertDisplayerProtocol {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = HomeViewModel()
    weak var coordinator: TabbarCoordinator?
    
    private var sectionHeight: CGFloat {
        let screenHeight = view.frame.height
        return screenHeight / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindLoadingIndicator(to: viewModel.stateRelay)
        bindAlert(to: viewModel.alertItemRelay)
        setupTableView()
        viewModel.fetchWhatToWatchMovies()
    }
}

// MARK: - Private Methods

private extension HomeViewController {
    typealias TableViewdataSource = RxTableViewSectionedReloadDataSource
    
    func setupTableView() {
        tableView.registerCellNib(HomeTableViewCell.self)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
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
            
            let cell: HomeTableViewCell = tableView.dequeue(at: indexPath)
            cell.setTitle(to: item.movieGroupType.title)
            item.moviesSubject
                .bind(to: cell.moviesSubject)
                .disposed(by: self.disposeBag)

            return cell
        })
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HomeTableViewHeader.fromNib()
        let title: String = viewModel.getTitle(for: section)
        headerView.titleLabel.text = title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
}
