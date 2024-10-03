//
//  PhotosViewController.swift
//  Navigation
//

import UIKit
import iOSIntPackage
import CoreFoundation

class PhotosViewController: UIViewController {
    
    let photoIdent = "photoCell"
    
    let imagePublisherFacade = ImagePublisherFacade()
    
    var images: [CGImage] = []
    
    var sourceImages: [UIImage] = Photos.shared.examples
    
    let imageProcessor = ImageProcessor()
    
    // MARK: Visual objects
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()

    lazy var photosCollectionView: UICollectionView = {
        let photos = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photos.translatesAutoresizingMaskIntoConstraints = false
        photos.backgroundColor = .white
        photos.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: photoIdent)
        return photos
    }()
    
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Setup section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photo Gallery"
        self.view.addSubview(photosCollectionView)
        self.photosCollectionView.dataSource = self
        self.photosCollectionView.delegate = self
        setupConstraints()
    
        class ParkBenchTimer {
            let startTime:CFAbsoluteTime
            var endTime:CFAbsoluteTime?

            init() {
                startTime = CFAbsoluteTimeGetCurrent()
            }

            func stop() -> CFAbsoluteTime {
                endTime = CFAbsoluteTimeGetCurrent()

                return duration!
            }

            var duration: CFAbsoluteTime? {
                if let endTime = endTime {
                    return endTime - startTime
                } else {
                    return nil
                }
            }
        }

        let timer = ParkBenchTimer()
        
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
        
        loadingIndicator.startAnimating()
        imageProcessor.processImagesOnThread(sourceImages: Photos.shared.examples, filter: .chrome, qos: .default) { images in
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                images.forEach { image in
                    guard let image = image else { return }
                    self.images.append(image)
                }
                self.photosCollectionView.reloadData()
                print("\(timer.stop()) seconds.")
            }
        }
    }
    
    //.background - 7.444963097572327 seconds.
    //.default - 5.765206933021545 seconds.
    //.userInitiated - 4.964640974998474 seconds.
    //.userInteractive - 4.909516096115112 seconds.
    //.utility - 5.710876941680908 seconds.
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Extensions

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let countItem: CGFloat = 2
        let accessibleWidth = collectionView.frame.width - 32
        let widthItem = (accessibleWidth / countItem)
        return CGSize(width: widthItem, height: widthItem * 0.56)
    }
}

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoIdent, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()}
        cell.configCellCollection(photo: images[indexPath.item])
        return cell
    }
}
