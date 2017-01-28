//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by LimJaemin on 2017. 1. 27..
//  Copyright © 2017년 LimJaemin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var currentRow: Int!
    var memes: [Meme]!
    var appDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memes = appDelegate.memes
        collectionView?.reloadData()
        
        super.viewWillAppear(animated)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CollectionViewController.openImageViewController))
        
        currentRow = indexPath.item

        let meme = memes[indexPath.item]

        cell.collectionImageView.image = meme.memedImage
        
        cell.addGestureRecognizer(tap)
        cell.isUserInteractionEnabled = true

        return cell
    }
    
    func openImageViewController() {
        let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        
        imageViewController.meme = memes[currentRow]
        
        present(imageViewController, animated: true, completion: nil)
    }
}
