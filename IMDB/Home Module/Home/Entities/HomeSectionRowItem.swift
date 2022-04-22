//
//  HomeSectionRowItem.swift
//  IMDB
//
//  Created by Ramy Sabry on 22/04/2022.
//

import RxDataSources

struct HomeSectionRowItem {
    var items: [HomeSectionRowData]
    
    init(items: [HomeSectionRowData]) {
        self.items = items
    }
}

extension HomeSectionRowItem: SectionModelType {
    typealias Item = HomeSectionRowData
    
    init(original: HomeSectionRowItem, items: [Item]) {
        self = original
        self.items = items
    }
}
