//
//  ViewController.swift
//  pokedex3
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/6/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var insearchMode = false
    var musicPlayer : AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }

    func parsePokemonCSV(){
     let PATH = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
    
        do{
            let csv = try CSV(contentsOfURL: PATH)
            let rows = csv.rows
            print(rows)
            for row in rows{
                let pokeid = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokeDexID: pokeid)
                pokemon.append(poke)
            }
        }catch let err as NSError{
            
            print(err.debugDescription)
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCell{
           // let pokemon = self.pokemon[indexPath.row]
            //cell.ConfigureCell(pokemon)
            let poke : Pokemon!
            if insearchMode{
                poke = filteredPokemon[indexPath.row]
                cell.ConfigureCell(poke)
            }else{
                 poke = self.pokemon[indexPath.row]
                cell.ConfigureCell(poke)
            }
            
            return cell
            
        }else{
            return UICollectionViewCell()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke : Pokemon!
        if insearchMode{
            poke = filteredPokemon[indexPath.row]
            
        }else{
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "pokemonDetailedVC", sender: poke)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if insearchMode{
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying{
            musicPlayer.pause()
           sender.alpha = 0.2
            
            
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            insearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        }else{
            insearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetailedVC"{
            if let detailedVC = segue.destination as? PokemonDetailedVC{
                if let poke = sender as? Pokemon{
                    detailedVC.pokemon = poke
                }
            }
        }
    }
    
    
    
    
}










