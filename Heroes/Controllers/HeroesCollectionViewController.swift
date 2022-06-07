//
//  HeroesCollectionViewController.swift
//  Heroes
//
//  Created by mac mini on 6/6/22.
//

import UIKit

class HeroesCollectionViewController: UICollectionViewController {
    
    private var heroes: [Hero] = []
    private var filteredHeroes: [Hero] = []
    
    private let itemPerRow: CGFloat = 3
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        fetchHeroes(from: Link.url.rawValue)
        
        collectionView.showsVerticalScrollIndicator = false

    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredHeroes.count
        }
        return heroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        
        var hero: Hero
        
        if isFiltering {
            hero = filteredHeroes[indexPath.item]
        } else {
            hero = heroes[indexPath.item]
        }
        
        cell.configure(with: hero)
    
        return cell
    }
    
    // MARK: - Private function
    
    private func fetchHeroes(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let heroes):
                self.heroes = heroes
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
    // MARK: - UICollectionViewDelegateFlowLayout
extension HeroesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInserts.left * (itemPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInserts.bottom
    }
}

// MARK: - UISearchResultsUpdating

extension HeroesCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterHeroForSearchText(searchController.searchBar.text!)
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search your hero"
        definesPresentationContext = true
    }

    
    private func filterHeroForSearchText(_ searchText: String) {
        filteredHeroes = heroes.filter({ (hero: Hero) -> Bool in
            return (hero.name?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        
        collectionView.reloadData()
    }
    
    
}


