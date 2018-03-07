//
//  ViewController.swift
//  RxSwiftMac02
//
//  Created by caijinzhu on 2018/3/7.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import Cocoa

import RxSwift

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        demo2()
    }
    
    fileprivate func demo1(){
        example(of: "debug") {
            let disposeBag = DisposeBag()
            
            Observable.of(1,2,3).debug("debug:", trimOutput: true).subscribe(onNext: { (value) in
                print("value = \(value)")
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed...")
            }).disposed(by: disposeBag)
            
        }
    }

    fileprivate func demo2(){
        let subject = PublishSubject<String>()
        let subscriptionOne = subject.subscribe(onNext: { (text) in
            print(text)
        })
        subject.onNext("Is there anynoe listening?")
        
        subject.onNext("en....somebody here..")
        
        let subscriptionTwo = subject.subscribe { (event) in
            print("two", event.element ?? event)
        }
        subject.onNext("3")
        subscriptionOne.dispose()
        subject.onNext("4")
        
        subject.onCompleted()
        subject.onNext("5")
        subscriptionTwo.dispose()
        
        let disposeBag = DisposeBag()
        subject.subscribe{
            print("three",$0.element ?? $0)
        }.disposed(by: disposeBag)
        
        
        subject.onNext("???")
    }

}


extension ViewController{
    fileprivate func example(of example: String, action: ()->Void){
        print("----Example \(example) ----")
        action()
    }
}
