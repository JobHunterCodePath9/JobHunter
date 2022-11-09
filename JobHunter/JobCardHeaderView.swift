//
//  JobCardHeaderView.swift
//  JobHunter
//
//  Created by Preston Barney on 11/8/22.
//

import UIKit



class JobCardHeaderView: UIView {

    private weak var textView: UITextView!
    private weak var imageView: UIImageView!
    
    
    
    init(frame: CGRect, jobTitle: String, jobDesc: String, image: UIImage) {
        super.init(frame: frame)
        setup(jobTitle: jobTitle, jobDesc: jobDesc, proFimage: image)
    }
    
    required init?(coder: NSCoder, jobTitle: String, jobDesc: String, image: UIImage) {
        super.init(coder: coder)
        setup(jobTitle: jobTitle, jobDesc: jobDesc, proFimage: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup (jobTitle: String, jobDesc: String, proFimage: UIImage){
        var profImageView = UIImageView()
        var titleTextView = UITextView()
        var descTextView = UITextView()
                
        
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        profImageView.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.isEditable = false
        titleTextView.isScrollEnabled = false
        descTextView.isEditable = false
        descTextView.isScrollEnabled = false
        
        addSubview(titleTextView)
        addSubview(descTextView)
        addSubview(profImageView)
        
        
        titleTextView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleTextView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        titleTextView.font = UIFont.boldSystemFont(ofSize: 30)
        titleTextView.textColor = .white
        titleTextView.backgroundColor = UIColor(red: 51/255, green: 13/255, blue: 148/255, alpha: 1)
        
        titleTextView.text = jobTitle
        
        descTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 0).isActive = true
        descTextView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        descTextView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        descTextView.heightAnchor.constraint(equalToConstant: 425).isActive = true
        descTextView.backgroundColor = .white
        descTextView.clipsToBounds = true
        
        descTextView.text = jobDesc
        
        profImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        profImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        profImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profImageView.clipsToBounds = true
        profImageView.layer.cornerRadius = 50

        profImageView.image = proFimage
        
        self.imageView = profImageView
        self.backgroundColor = .white

    }
    


}
