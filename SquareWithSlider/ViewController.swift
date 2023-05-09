//
//  ViewController.swift
//  SquareWithSlider
//
//  Created by Alisher on 08.05.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1.0
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderTouchUp(_:)), for: .touchUpInside)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var squareViewLeadingConstraint: NSLayoutConstraint! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(squareView)
        view.addSubview(slider)
        
        squareViewLeadingConstraint = squareView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        
        NSLayoutConstraint.activate([
            squareViewLeadingConstraint,
            squareView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            squareView.widthAnchor.constraint(equalToConstant: Constants.squareViewSize),
            squareView.heightAnchor.constraint(equalToConstant: Constants.squareViewSize),
            
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            slider.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 40),
            slider.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let angle = CGFloat(sender.value) * .pi / 2
        let scale = min(CGFloat(sender.value) + 1.0, 1.5)
        let translation = CGFloat(sender.value) * (sender.frame.width - Constants.squareViewSize * Constants.squareViewScaleValue)
        let rotationTransform = CGAffineTransform(rotationAngle: angle)
        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        
        squareViewLeadingConstraint.constant = translation
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState]) {
            self.squareView.transform = rotationTransform.concatenating(scaleTransform)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func sliderTouchUp(_ sender: UISlider) {
        guard sender.value != sender.maximumValue else {
            return
        }
        
        sender.setValue(sender.maximumValue, animated: true)
        self.sliderValueChanged(sender)
    }
}

enum Constants {
    static var squareViewSize: CGFloat = 70
    static var squareViewScaleValue: CGFloat = 1.5
}

