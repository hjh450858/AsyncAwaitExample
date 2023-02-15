//
//  ViewController.swift
//  AsyncAwaitExample
//
//  Created by 황재현 on 2023/02/15.
//

import UIKit

class ViewController: UIViewController {
    // 버튼
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("이미지", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // 이미지를 보여줄 뷰
    private let image: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(button)
        self.view.addSubview(image)
        // 위치 설정
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        // 위치 설정
        NSLayoutConstraint.activate([
            self.image.widthAnchor.constraint(equalToConstant: 100),
            self.image.heightAnchor.constraint(equalToConstant: 100),
            self.image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.image.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc func didTap() {
        guard let url = URL(string: "https://reqres.in/api/users?page=1") else { return }
        Task {
            // MARK: - await = 이 메서드 작업이 끝날때까지 기다림
            guard let imageURL = try? await requestImageURL(requestURL: url),
                  let url = URL(string: imageURL),
//                  let data = try? Data(contentsOf: url)
                    let data = try? await URLSession.shared.data(from: url)
            else { return }
            print(Thread.isMainThread)
//            self.image.image = UIImage(data: data)
            self.image.image = UIImage(data: data.0)
        }
    }
    
    // MARK: - async = 함수를 비동기로 처리하겠다고 선언
    func requestImageURL(requestURL: URL) async throws -> String {
        // 메인스레드인지 체크
        print(Thread.isMainThread)
        let (data, _) = try await URLSession.shared.data(from: requestURL)
        return try JSONDecoder().decode(DataModel.self, from: data).data.first?.avatar ?? ""
    }
}

