import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var tableView: UITableView!
    var items: [String] = ["Movie0", "Movie1", "Movie2", "Movie3"]
    var movieResponse: AnyObject?
    var movieData: NSData?
    var movieArray = [Double]()
    var cell = UITableViewCell()
    var json: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func sortByPopularity() {
        
    }
    
    func getMovies() {
        Alamofire.request(.GET, "https://api.themoviedb.org/3/discover/movie", parameters: ["sort_by" : "popularity", "api_key" : "08b5d2ec7ac05e1a512f2152954d31f2"])
        .validate()
        .responseJSON { response in
        switch response.result {
            case .Success:
                self.json = JSON(response.result.value!)
                print(self.findMovieByPopularity(1.000826))
                let arraySize: Int = self.json["results"].count
                for num in 0...arraySize - 1 {
                    let x = self.json["results"][num]["popularity"]
                    self.movieArray.append(x.double!)
                    self.movieArray.sortInPlace()
                }
                for num in 0...arraySize - 1 {
                    let path = NSIndexPath(forRow: num, inSection: 0)
                    let cell = self.tableView.cellForRowAtIndexPath(path)
                    cell?.textLabel?.text = (self.findMovieByPopularity(self.movieArray[num]) + ":    " + String(self.movieArray[num]))
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func findMovieByPopularity(popularity: Double) -> String {
        for num in 0...json["results"].count {
            if self.json["results"][num]["popularity"].double! == popularity {
                return self.json["results"][num]["title"].string!
            }
        }
        return "null"
    }
    
}