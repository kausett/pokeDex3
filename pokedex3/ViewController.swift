//
//  ViewController.swift
//  pokedex3
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/6/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var pokemon = [Pokemon]()
    var musicPlayer : AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
      
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
            let pokemon = self.pokemon[indexPath.row]
            cell.ConfigureCell(pokemon)
            
            return cell
            
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
}

