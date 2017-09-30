//
//  LoginController.swift
//  OnTheMap
//
//  Created by Martin Janák on 11/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit
import ReachabilitySwift

class LoginController: UIViewController {
    
    lazy var gradientView: GradientView = {
        let grad = GradientView()
        grad.startColor = Color.background
        grad.endColor = Color.backgroundDark
        return grad
    }()
    
    lazy var logoImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "logo-u")!
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login to Udacity"
        label.textColor = Color.textLight
        label.font = UIFont.systemFont(ofSize: Dimension.text)
        return label
    }()
    
    lazy var usernameField: SmartTextField = {
        let field = SmartTextField()
        field.placeholder = "Username"
        field.backgroundColor = Color.backgroundLight
        field.textColor = Color.textDark
        field.layer.cornerRadius = Dimension.cornerRadius
        field.autocorrectionType = .no
        
        field.text = "janak.martin@email.cz" // TODO
        
        return field
    }()
    
    lazy var passwordField: SmartTextField = {
        let field = SmartTextField()
        field.placeholder = "Password"
        field.backgroundColor = Color.backgroundLight
        field.textColor = Color.textDark
        field.layer.cornerRadius = Dimension.cornerRadius
        field.isSecureTextEntry = true
        
        field.text = "i3wl@UN5lp&H:hIL" // TODO
        
        return field
    }()
    
    lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(Color.textLight, for: .normal)
        btn.backgroundColor = Color.tint
        btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        btn.layer.cornerRadius = Dimension.cornerRadius
        btn.set(enabled: false)
        return btn
    }()
    
    lazy var signUpView: UIView = UIView()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = Color.textLight
        label.font = UIFont.systemFont(ofSize: Dimension.text)
        return label
    }()
    
    lazy var signUpButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(Color.textLight, for: .normal)
        btn.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: Dimension.text)
        return btn
    }()
    
    var topConstraint: NSLayoutConstraint!
    
    func login(_ sender: Any) {
        
        guard let status = Reachability()?.currentReachabilityStatus else {
            return
        }
            
        switch status {
            case .reachableViaWiFi, .reachableViaWWAN:
                
                Loader.show(controller: self)
                
                UdacityClient.shared.postSession(
                    username: usernameField.text!,
                    password: passwordField.text!
                ) { success in
                    
                    ModelCache.shared.loadUser(handler: nil)
                    
                    Loader.hide() {
                        if success {
                            let tabBarController = TabBarController()
                            self.present(tabBarController, animated: true, completion: nil)
                        } else {
                            Alert.notify(
                                title: "Unable to log in",
                                message: "Incorrect email or password",
                                controller: self
                            )
                        }
                    }
                }
            case .notReachable:
                Alert.notify(
                    title: "Unable to log in",
                    message: "You are not connected to the internet",
                    controller: self
                )
        }
    }
    
    func signUp() {
        if let url = URL(string: "https://www.udacity.com/account/auth#!/signup") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(textField: usernameField)
        setup(textField: passwordField)
        
        view.add(gradientView)
        view.add(logoImageView)
        view.add(loginLabel)
        view.add(usernameField)
        view.add(passwordField)
        view.add(loginButton)
        
        view.add(signUpView)
        signUpView.add(signUpLabel)
        signUpView.add(signUpButton)
        
        setupConstraints()
    }
    
    func setup(textField: SmartTextField) {
        
        let textValidator: (String?) -> Bool = { text in
            if let text = text {
                return text != ""
            } else {
                return false
            }
        }
        
        let onTextChange: () -> Void = {
            self.loginButton.set(enabled: self.usernameField.isValid() && self.passwordField.isValid())
        }
        
        textField.validator = textValidator
        textField.onTextChange = onTextChange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameField.subscribeKeyboardListener(contentView: view)
        passwordField.subscribeKeyboardListener(contentView: view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        usernameField.unsubscribeKeyboardListener()
        passwordField.unsubscribeKeyboardListener()
    }
    
    private func setupConstraints() {
        
        view.constrainContainer(gradientView, lead: 0, trail: 0, top: 0, bottom: 0)
        
        logoImageView.constrainSize(width: 110, height: 110)
        view.constrainCenter(logoImageView, horizontal: 0, vertical: nil)
        _ = view.constrainTop(logoImageView, constant: 70)
        
        view.constrainCenter(loginLabel, horizontal: 0, vertical: nil)
        topConstraint = view.constrainTop(loginLabel, constant: 210)
        
        usernameField.constrainSize(width: 260, height: 50)
        view.constrainCenter(usernameField, horizontal: 0, vertical: nil)
        _ = view.constrainVertical(from: usernameField, to: loginLabel, constant: 20)
        
        passwordField.constrainSize(width: 260, height: 50)
        view.constrainCenter(passwordField, horizontal: 0, vertical: nil)
        _ = view.constrainVertical(from: passwordField, to: usernameField, constant: 12)
        
        loginButton.constrainSize(width: 260, height: 50)
        view.constrainCenter(loginButton, horizontal: 0, vertical: nil)
        _ = view.constrainVertical(from: loginButton, to: passwordField, constant: 12)
        
        signUpView.constrainSize(width: 260, height: 60)
        _ = view.constrainVertical(from: signUpView, to: loginButton, constant: 12)
        view.constrainCenter(signUpView, horizontal: 0, vertical: nil)
        
        signUpView.constrainCenter(signUpLabel, horizontal: nil, vertical: 0)
        _ = signUpView.constrainLead(signUpLabel, constant: 0)
        
        signUpView.constrainCenter(signUpButton, horizontal: nil, vertical: 0)
        _ = signUpView.constrainTrail(signUpButton, constant: 0)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.verticalSizeClass == .compact {
            logoImageView.isHidden = true
            topConstraint.constant = 20
        } else {
            logoImageView.isHidden = false
            topConstraint.constant = 210
        }
    }
    
}
