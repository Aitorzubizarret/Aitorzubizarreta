//
//  CustomImageView.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 28/8/22.
//

import UIKit

final class CustomImageView: UIImageView {
    
    // MARK: - Properties
    
    private var originalCenter: CGPoint?
    private var pinchGesture: UIPinchGestureRecognizer?
    private var panGesture: UIPanGestureRecognizer?
    
    // MARK: - Methods
    
    ///
    /// Adds a Pinch and a Zoom Gesture Recognizers.
    /// and enables user interaction.
    ///
    func enableZoomAndPan() {
        // Pinch Gesture Recognizer.
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(imageZooming(_:)))
        pinchGesture?.delegate = self
        addGestureRecognizer(pinchGesture!)
        
        // Pan Gesture Recognizer.
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(imagePanning(_:)))
        panGesture?.delegate = self
        addGestureRecognizer(panGesture!)
        
        isUserInteractionEnabled = true
        
        superview?.clipsToBounds = false
    }
    
    @objc private func imageZooming(_ sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .began:
            layer.zPosition = 1
            superview?.layer.zPosition = 1
        case .changed:
            guard let safeView = sender.view else { return }
            
            let center = CGPoint(x: sender.location(in: safeView).x - safeView.bounds.midX,
                                 y: sender.location(in: safeView).y - safeView.bounds.midY)
            
            safeView.transform = safeView.transform.translatedBy(x: center.x, y: center.y)
            safeView.transform = safeView.transform.scaledBy(x: sender.scale, y: sender.scale)
            safeView.transform = safeView.transform.translatedBy(x: -center.x, y: -center.y)
            
            sender.scale = 1
        default:
            resetZoomAndPan()
        }
    }
    
    @objc private func imagePanning(_ sender: UIPanGestureRecognizer) {
        //guard sender.numberOfTouches >= 2 else { return }
        
        switch sender.state {
        case .began:
            originalCenter = sender.view?.center
        case .changed:
            guard let safeView = sender.view else { return }
            
            let translation = sender.translation(in: self)
            safeView.center = CGPoint(x: (safeView.center.x + translation.x), y: (safeView.center.y + translation.y))
            sender.setTranslation(.zero, in: superview)
        default:
            resetZoomAndPan()
        }
    }
    
    private func resetZoomAndPan() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.center = self.originalCenter ?? self.center
        } completion: { _ in
            self.layer.zPosition = 0
            self.superview?.layer.zPosition = 0
        }
    }
    
}

// MARK: - UIGesture Recognizer Delegate

extension CustomImageView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == pinchGesture && otherGestureRecognizer.view is UIScrollView {
            return false
        }
        
        if gestureRecognizer == panGesture && otherGestureRecognizer.view is UIScrollView {
            return false
        }
        
        return true
    }
    
}
