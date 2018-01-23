//
//  ModelTransition.swift
//  Newsreader
//
//  Created by Wouter Vermeij on 09/11/2017.
//  Copyright © 2017 Wouter Vermeij. All rights reserved.
//


/* Met dank aan Wouter! */
import Foundation

protocol ModalTransitionListener {
    func popoverDismissed()
}

class ModalTransitionMediator {
    /* Singleton */
    class var instance: ModalTransitionMediator {
        struct Static {
            static let instance: ModalTransitionMediator = ModalTransitionMediator()
        }
        return Static.instance
    }
    
    private var listener: ModalTransitionListener?
    
    private init() {
        
    }
    
    func setListener(listener: ModalTransitionListener) {
        self.listener = listener
    }
    
    func sendPopoverDismissed(modelChanged: Bool) {
        listener?.popoverDismissed()
    }
}
