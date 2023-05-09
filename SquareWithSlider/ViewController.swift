//
//  ViewController.swift
//  SquareWithSlider
//
//  Created by Alisher on 08.05.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private let animator = UIViewPropertyAnimator(duration: 0.7, curve: .easeOut)
    private lazy var squareView: UIView = {
        let view = UIView(frame: CGRect(
            x: view.layoutMargins.left,
            y: 110,
            width: Constants.squareViewSize,
            height: Constants.squareViewSize))
        view.backgroundColor = .systemBlue
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider(frame: CGRect(
            x: view.layoutMargins.left,
            y: squareView.frame.maxY + 40,
            width: view.frame.width - view.layoutMargins.left - view.layoutMargins.right,
            height: 10))
        slider.minimumValue = 0
        slider.maximumValue = 1.0
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderTouchUp(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderTouchUp(_:)), for: .touchUpInside)
        return slider
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
         
        animator.pausesOnCompletion = true
        animator.addAnimations {
            self.squareView.frame.origin.x = self.view.frame.width - self.view.layoutMargins.left  - self.squareView.frame.width
            self.squareView.transform  = .init(scaleX: 1.5, y: 1.5).rotated(by: .pi / 2)
        }
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(squareView)
        view.addSubview(slider)
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc private func sliderTouchUp(_ sender: UISlider) {
        animator.startAnimation()
        sender.setValue(sender.maximumValue, animated: true)
    }
}

enum Constants {
    static var squareViewSize: CGFloat = 80
    static var squareViewScaleValue: CGFloat = 1.5
}
