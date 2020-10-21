//
//  ViewController.swift
//  TrackingStepsRxSwift
//
//  Created by Айдар on 12.08.2020.
//  Copyright © 2020 Айдар. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!
    
    var pedometer = CMPedometer()
    var numberOfSteps: Int = 0
    var startDate: Date? = nil
    var steps: Int = 0
    let disposeBag = DisposeBag()
   
    /*private func setPedometerDate( pedometerDate: CMPedometerData) {
    self.numberOfSteps = Int(truncating: pedometerDate.numberOfSteps)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let test = Observable<Int>.create ({ [self] (observer) -> Disposable in
                startDate = Date()
                pedometer.startUpdates(from: Date()) { (ped, error) in
                    if let ped = ped {
                        self.setPedometerDate(pedometerDate: ped)
                        self.steps = self.numberOfSteps
                    }
                }; return Disposables.create()
        })
        test.subscribe { (observer) in
            self.countLabel.text = ("Шаги:\(self.steps)")
        }*/
        let test = Observable<CMPedometerData>.create ({ (observer) in
            self.pedometer.startUpdates(from: Date()) { (ped, error) in
                if let ped = ped {
                    observer.on(.next(ped))
                }
            }
            return Disposables.create()
        })
        test.subscribe(onNext: { ped in
            self.steps = Int(truncating: ped.numberOfSteps)
            DispatchQueue.main.async {
                self.countLabel.text = ("Шаги:\(self.steps)")
            }
        })
    }
}




