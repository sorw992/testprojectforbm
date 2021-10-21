

import XCTest
@testable import test_project



class SearchTest: XCTestCase {
    
    var sut: ViewController!
    
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        
        sut = nil
        
        super.tearDown()
        
    }
    
    func testUrlSearch_IsExplicit() {
        
        XCTAssertEqual(urlSearch, "http://www.omdbapi.com/?apikey=a5100646&s=")
        
    }
    
    func testUrl_ExpectedHost() {
        print("dfsfsd", URL(string: urlSearch)?.host ?? "")
        XCTAssertEqual(URL(string: urlSearch)?.host, "www.omdbapi.com")
    }
    
    func testUrlSearch_IsSearchKeywordAdded() {
        
        let searchKeyword = "terminator"
        
        XCTAssertEqual("\(urlSearch)\(searchKeyword)", "http://www.omdbapi.com/?apikey=a5100646&s=terminator")
        
    }
    
    func testSearchApi_Performance() {
        
        // you should set baseline average for time
        measure {
            
            sut.searchViewModel.fetchMovies(url: "\(urlSearch)terminator", identifier: "firsttime", lblPageNumber: sut.lblPageNumber, tableView: sut.tableView, btnPrevious: sut.btnPrevious, btnNext: sut.btnNext, view: sut, completion: { _ in
            })
        }
    }
    
    
    
    func testGetMovies_SuccessReturnsResponse() {
    
        // terminator is a search keyword
        let url = URL(string: "\(urlSearch)terminator")
        
        let sessionAnsweredExpectation = expectation(description: "SuccessReturnsResponse")
        
        // we're gonna make sure the session answers and returns a result to us
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
           
            if let error = error {
                
                XCTFail(error.localizedDescription)
                
            }
            
            
            if let httpResponse = response as? HTTPURLResponse {
                   print("statusCode: \(httpResponse.statusCode)")
                if "\(httpResponse.statusCode)" != "200" {
                    XCTFail("http response status code is not 200")
                }
            }
            
            // print("response", response)
         
            sessionAnsweredExpectation.fulfill()

            
            
        }.resume()
        
       
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}
