import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var tableView: UITableView!
    var items: [String] = ["Movie0", "Movie1", "Movie2", "Movie3"]
    var movieResponse: AnyObject?
    var movieData: NSData?
    var movieArray: [JSON]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "https://api.themoviedb.org/3/discover/movie", parameters: ["sort_by" : "popularity", "api_key" : "08b5d2ec7ac05e1a512f2152954d31f2"])
        
        .validate()
        .responseJSON { response in
            switch response.result {
                case .Success:
                    let json = JSON(response.result.value!)
                    //print(json)
                    let arraySize: Int = json["results"].count
                    for num in 0...arraySize {
                        let x = json["results"][num]["title"]
                        print(x)
                        self.movieArray[num] = (x)
                    }
                    print(self.movieArray[0])
                
                case .Failure(let error):
                    print(error)
                }
        }
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
}