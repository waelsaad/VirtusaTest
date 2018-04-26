//
//  FactCollectionViewCell.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import UIKit
import SDWebImage

// Protocol called once cell is ready to be resized
protocol ImageDownloaded {
    // Once image is downloaded its called so that UI can adjust itself
    func cellReadyToBeResized(at index: Int, size: CGSize)
}

class FactCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate : ImageDownloaded!
    var viewModel : HomeCellViewModel!
    
    func loadData(viewModel : HomeCellViewModel, delegate: ImageDownloaded) {
        self.viewModel = viewModel
        self.delegate = delegate
        self.titleLabel.text = self.viewModel.title
        if let url = viewModel.imageUrl {
            self.imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: APPIMAGES.NoImageAvailable), options: .allowInvalidSSLCertificates, completed: { (image, error, cacheType, url) in
                if let downloadedImage = image{
                    let size = CGSize(width: downloadedImage.size.width, height: downloadedImage.size.height + self.titleLabel.frame.height)
                    self.delegate.cellReadyToBeResized(at: self.viewModel.index, size: size)
                }
            })
        }
        else
        {
            self.imageView.image = UIImage(named: APPIMAGES.NoImageAvailable)
        }
    }
}
