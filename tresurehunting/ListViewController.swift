import UIKit

class ListViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate {
    
    // 画像の名前を配列とする
    let photos = ["sample","sakura","3", "4","5","6","7","8","9","10","11","12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        // dequeueReusableCellWithReuseIdentifier の働きは
        // 再利用できるセルがあればそれを使う
        // 再利用できるセルがなければ生成する
        // Cell はストーリーボードで設定したセルのID
        let Cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = Cell.contentView.viewWithTag(1) as! UIImageView
        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
        let cellImage = UIImage(named: photos[indexPath.row])
        // UIImageをUIImageViewのimageとして設定
        imageView.image = cellImage
        
        // Tag番号を使ってLabelのインスタンス生成
        let label = Cell.contentView.viewWithTag(2) as! UILabel
        label.text = photos[indexPath.row]
        
        return Cell
    }
    //section 数の設定、今回は１つにセット
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return 12
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

