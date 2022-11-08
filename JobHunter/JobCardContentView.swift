//
//  JobCardContentView.swift
//  JobHunter
//
//  Created by Preston Barney on 11/7/22.
//

import UIKit

class JobCardContentView: UICollectionView{
    
    
    
    override init(
        frame: CGRect,
        collectionViewLayout layout: UICollectionViewLayout
    ){
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var cellId = "cellId"
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 2
       }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! JobCardContentViewCell
            return cell
        }
    

}


class JobCardContentViewCell: UICollectionViewCell{
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Job Name"
        return label
    }()
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Job location"
        return label
    }()
    
    

    override init(frame: CGRect) {
          super.init(frame: frame)

          addViews()
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        addSubview(nameLabel)
                
    }
}
