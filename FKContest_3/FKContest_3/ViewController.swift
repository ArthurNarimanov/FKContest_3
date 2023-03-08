//
//  ViewController.swift
//  FKContest_3
//
//  Created by Arthur Narimanov on 3/7/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let animator: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator(duration: Constants.duration, curve: .linear)
        animator.pausesOnCompletion = true
        return animator
    }()
    
    private let box: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 16
        view.layer.cornerCurve = .circular
        return view
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.tintColor = .systemBlue
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(box)
        view.addSubview(slider)
        
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(self.sliderTouchUpInside(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(self.sliderTouchDown(_:)), for: .touchDown)
        
        animator.addAnimations {
            self.box.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
            self.box.bounds.size = CGSize(width: self.box.bounds.size.width * 1.5,
                                          height: self.box.bounds.size.height * 1.5)
            self.box.frame.origin.x = self.slider.frame.maxX - self.box.frame.width
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard slider.value == 0 else { return }
        box.frame = CGRect(x: view.layoutMargins.left, y: 100, width: 100, height: 100)
        slider.frame = CGRect(x: view.layoutMargins.left,
                              y: box.frame.maxY + 50,
                              width: view.bounds.width - view.layoutMargins.right - view.layoutMargins.left,
                              height: 30)
    }
    
    @objc
    func sliderValueDidChange(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc
    func sliderTouchUpInside(_ sender: UISlider) {
        animator.startAnimation()
        UIView.animate(withDuration: Constants.duration) {
            self.slider.setValue(self.slider.maximumValue, animated: true)
        }
    }
    
    @objc
    func sliderTouchDown(_ sender: UISlider) {
        animator.pauseAnimation()
    }
    
    enum Constants {
        static let duration: CGFloat = 0.3
    }
}
