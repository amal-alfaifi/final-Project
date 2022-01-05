//
//  SearchInputView.swift
//  MyApp
//
//  Created by Amal on 30/05/1443 AH.
//

import UIKit
import MapKit

private let  reuseIdentfire = "SearchCell"

protocol SearchInputViewDelegate {
    func animateCenterMapButton(expansionState: SearchInputView.ExpansionState , hideButton: Bool)
    func handleSearch(withSearchText searchText: String)
    func addPolyline(forDestinationMapItem destinationMapItem: MKMapItem)
    func selectedAnnotation (withMapItem mapItem: MKMapItem)
}

class SearchInputView: UIView {
    
    var searchBar: UISearchBar!
    var tableView: UITableView!
    var expansionState: ExpansionState!
    var delegate: SearchInputViewDelegate?
    var mapController: MapController?


    var searchResults: [MKMapItem]? {
       didSet {
           tableView.reloadData()
       }
    }

    enum ExpansionState {
        case NotExpanded
        case PartiallyExpanded
        case FullyExpanded
    }
    let indicatorView: UIView = {
       let view = UIView()
       view.backgroundColor = .lightGray
       view.layer.cornerRadius = 5
       view.alpha = 0.8
       return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
        
        expansionState = .NotExpanded
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        if sender.direction == .up {
            if expansionState == .NotExpanded {
                self.delegate?.animateCenterMapButton(expansionState: self.expansionState, hideButton: false)
                animateInputView(targetPosition: self.frame.origin.y - 200) { (_) in
                    self.expansionState = .PartiallyExpanded
                }
            }
            if expansionState == .PartiallyExpanded {
                self.delegate?.animateCenterMapButton(expansionState: self.expansionState, hideButton: true)
                animateInputView(targetPosition: self.frame.origin.y - 450) { (_) in
                    self.expansionState = .FullyExpanded
                }
            }
            
        } else {
            
            if expansionState == .FullyExpanded {
                self.searchBar.endEditing(true)
                self.searchBar.showsCancelButton = false
                
                animateInputView(targetPosition: self.frame.origin.y + 450) { (_) in
                    self.delegate?.animateCenterMapButton(expansionState: self.expansionState, hideButton: false)
                    self.expansionState = .PartiallyExpanded
                }
            }
            if expansionState == .PartiallyExpanded {
                self.delegate?.animateCenterMapButton(expansionState: self.expansionState, hideButton: false)
                animateInputView(targetPosition: self.frame.origin.y + 200) { (_) in
                    self.expansionState = .NotExpanded
                    
                }
            }
        }
    }
    
    // MARK: - Helper function
    
    func dismissOnSearch() {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        animateInputView(targetPosition: self.frame.origin.y + 500) { (_) in
            self.delegate?.animateCenterMapButton(expansionState: self.expansionState, hideButton: false)
            self.expansionState = .PartiallyExpanded
    }
    }
        
    func animateInputView(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut,
            animations: {
            self.frame.origin.y = targetPosition
       }, completion: completion)
    }
    func configureViewComponents() {
        backgroundColor = .white
        
        addSubview(indicatorView)
        indicatorView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 8)
        indicatorView.centerX(inView: self)
        
        configureSearchBar()
        configureTableView()
        configureGestureRecognizers()
    }
    func configureSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Search for a place or address"
        searchBar.barStyle = .black
        searchBar.delegate = self
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        addSubview(searchBar)
        searchBar.anchor(top: indicatorView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.rowHeight = 72
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentfire)
        
        addSubview(tableView)
        tableView.anchor(top: searchBar.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 100, paddingRight: 0, width: 0, height: 0)
    }
    
    func configureGestureRecognizers() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeUp.direction = .up
        addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeDown.direction = .down
        addGestureRecognizer(swipeDown)
    }
}

// MARK: - UISearchBarDelegate

extension SearchInputView : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked (_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        delegate?.handleSearch(withSearchText: searchText)
        dismissOnSearch()
    }
    
    func searchBarTextDidBeginEditing( searchBar: UISearchBar) {
        
       if expansionState == .NotExpanded {
           delegate?.animateCenterMapButton(expansionState: self.expansionState, hideButton: true)
           animateInputView(targetPosition: self.frame.origin.y - 750) { (_) in
               self.expansionState = .FullyExpanded
           }
       }
        
       if expansionState == .PartiallyExpanded {
           delegate?.animateCenterMapButton(expansionState: self.expansionState, hideButton: true)
           animateInputView(targetPosition: self.frame.origin.y - 500) { (_) in
               self.expansionState = .FullyExpanded
           }
       }
       searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissOnSearch()
    }
}
        
// MARK: - UITableViewDataSource/Delegate

extension SearchInputView: UITableViewDelegate , UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchResults = searchResults else { return 0}
        return searchResults.count
                                   
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentfire, for: indexPath) as! SearchCell
        
        if let controller = mapController {
           cell.delegate = controller
        }
        
        if let searchResults = searchResults {
           cell.mapItem = searchResults[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard var searchResults = searchResults else { return }
       let selectedMapItem = searchResults[indexPath.row]
        delegate?.selectedAnnotation(withMapItem: selectedMapItem)
        
        if expansionState == .FullyExpanded {
            self.searchBar.endEditing(true)
            self.searchBar.showsCancelButton = false
            
            animateInputView(targetPosition: self.frame.origin.y + 500) { (_) in
                self.delegate?.animateCenterMapButton(expansionState: self.expansionState, hideButton: false)
                self.expansionState = .PartiallyExpanded
            }
        }
        searchResults.remove(at: indexPath.row)
        searchResults.insert(selectedMapItem, at: 0)
        self.searchResults = searchResults
        
        let firstIndexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: firstIndexPath) as! SearchCell
        cell.animateButtonIn()
        
        delegate?.addPolyline(forDestinationMapItem: selectedMapItem)

    }
}
