//
//  HomeVC.swift
//  BunnyChrono
//
//  Created by SHREE RAM on 24/10/24.
//

import UIKit

class BunnyHomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   

    @IBOutlet weak var collViewHome: UICollectionView!
    
    var arrAnimalName = ["Elephant","Panda","Giraffe","Bear","Koala","Tiger","Kangaroo","Zebra","Bison","Yak","Otter","Hippopotamus"]
    
    var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            _flowLayout.itemSize = CGSize(width: self.collViewHome.frame.size.width/2-5, height:120)
            
            _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            _flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
            _flowLayout.minimumInteritemSpacing = 0
            _flowLayout.minimumLineSpacing = 0
        }
        
        return _flowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collViewHome.delegate = self
        collViewHome.dataSource = self
        collViewHome.register(UINib.init(nibName: "AnimalCell", bundle: nil), forCellWithReuseIdentifier: "AnimalCell")
        navigationController?.navigationBar.isHidden = true
        collViewHome.collectionViewLayout = self.flowLayout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAnimalName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collViewHome.dequeueReusableCell(withReuseIdentifier: "AnimalCell", for: indexPath) as! AnimalCell
        cell.lblMain.text = arrAnimalName[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalculateVC") as! BunnyCalculateViewController
        vc.animalName = arrAnimalName[indexPath.row]
        if indexPath.row == 0{
            vc.isFromAnimal = "Elephant"
        }else if indexPath.row == 1{
            vc.isFromAnimal = "Panda"
        }else if indexPath.row == 2{
            vc.isFromAnimal = "Giraffe"
        }else if indexPath.row == 3{
            vc.isFromAnimal = "Bear"
        }else if indexPath.row == 4{
            vc.isFromAnimal = "Koala"
        }else if indexPath.row == 5{
            vc.isFromAnimal = "Tiger"
        }else if indexPath.row == 6{
            vc.isFromAnimal = "Kangaroo"
        }else if indexPath.row == 7{
            vc.isFromAnimal = "Zebra"
        }else if indexPath.row == 8{
            vc.isFromAnimal = "Bison"
        }else if indexPath.row == 9{
            vc.isFromAnimal = "Yak"
        }else if indexPath.row == 10{
            vc.isFromAnimal = "Otter"
        }else if indexPath.row == 11{
            vc.isFromAnimal = "Hippopotamus"
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
