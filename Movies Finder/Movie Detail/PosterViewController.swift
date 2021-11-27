//
//  PosterViewController.swift
//  Movies Finder
//
//  Created by Noel Conde Algarra on 27/11/21.
//

import UIKit

class PosterViewController: UIViewController {

    @IBOutlet weak var poster: UIImageView! {
        didSet {
            poster.sd_setImage(with: URL(string: urlPoster),
                               placeholderImage: UIImage(named: "posterPlaceholder"))
        }
    }
    @IBOutlet weak var viewBackground: UIView! {
        didSet {
            viewBackground.alpha = 0.8
            viewBackground.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                       action: #selector(close)))
        }
    }
    @IBOutlet weak var btnDownload: UIButton! {
        didSet {
            btnDownload.layer.cornerRadius = btnDownload.frame.height / 2
            btnDownload.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
            btnDownload.layer.shadowOffset = CGSize(width: 0, height: 3)
            btnDownload.layer.shadowOpacity = 0.7
            btnDownload.layer.shadowRadius = 3
        }
    }
    
    private var urlPoster: String
    
    init(_ urlPoster: String) {
        self.urlPoster = urlPoster
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors

    @objc func close() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlert(onViewController: self,
                      title: "Error al guardar",
                      mssg: error.localizedDescription)
        } else {
            showAlert(onViewController: self,
                      title: "¡Portada guardada!",
                      mssg: "Se ha guardado la portada de la película en tus fotos.")
        }
    }
    
    // MARK: Actions
    
    @IBAction func downloadPoster(_ sender: Any) {
        if let imgPoster = poster.image {
            UIImageWriteToSavedPhotosAlbum(imgPoster, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        } else {
            showAlert(onViewController: self,
                      title: "Descarga de imagen",
                      mssg: "No se pudo descargar la imagen en sus fotos.")
        }
    }
}
