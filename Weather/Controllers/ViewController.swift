//
//  ViewController.swift
//  Weather
//
//  Created by Тимур Гутиев on 14.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageToAnimate: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.2, execute: {() in self.animation()}) // после загрузки лончскрина через xx сек начнется анимация
    }

    func animation() {
        UIView.animate(withDuration: 2.0) { //  анимация будет длиться xx сек
            self.imageToAnimate.transform = CGAffineTransform(scaleX: 6, y: 6) // за xx сек картинка увел-ся в 6 раз
        }
        
        UIView.animate(withDuration: 2.6, animations: {() in //  анимация для исчез-я картинки за xx сек
            self.imageToAnimate.alpha = 0
        }, completion: {ok in // по окончанию растворения будет переход на 2й вьюконтролер
            if ok {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {() in
                    guard let baseViewController = self.storyboard?.instantiateViewController(identifier: "homeVC") as? HomeViewController else {
                        print("error!")
                        return
                    }
                    baseViewController.modalTransitionStyle = .crossDissolve
                    baseViewController.modalPresentationStyle = .fullScreen
                    self.present(baseViewController, animated: true, completion: nil)
                })
            }
        })
        
    }

}

