//
//  FactViewModel.swift
//  VirtusaTest
//
//  Created by Wael Saad on 26/4/18.
//  Copyright © 2018 nettrinity.com.au. All rights reserved.
//

import Foundation

protocol NetworkResponse {
    func stateChanged(success : Bool, error: String)
}


class FactViewModel {
    
    var numberOfCells : Int { return facts.count }
    private let webservice :FactWebservice
    var facts  = Array<Fact>.init()
    private var selectedCell : Int?
    private let delegate: NetworkResponse
    
    func viewModelForCell(at index: Int) -> FactCellViewModel {
        return FactCellViewModel(fact: facts[index], index: index)
    }
    
    func cellSelected(index: Int) {
        selectedCell = index
    }
    
    func selectedViewModel() -> FactCellViewModel {
        return viewModelForCell(at: selectedCell!)
    }
    
    init(delegate : NetworkResponse) {
        self.delegate = delegate
        webservice = FactWebservice.init()
    }
    
    // Fetch the Facts data and display it
    func refreshData() {
        webservice.fetchFeed { (result) in
            switch result{
            case .response(let data):
                self.facts = data
                self.delegate.stateChanged(success: true, error: "")
                break
            case .error(error: let error):
                self.facts.removeAll()
                self.delegate.stateChanged(success: false, error: error.localizedDescription)
                break
            }
        }
    }
}
