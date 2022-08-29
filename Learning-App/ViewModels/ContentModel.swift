//
//  ContentModel.swift
//  Learning-App
//
//  Created by Prisha Anand on 8/28/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    //update view code according to parsed JSON data
    @Published var modules = [Module]()
    
    //does not need to be published bc will not be changed after first initialization
    var styleData: Data?
    
    //keep track of selected module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    init() {
        getLocalData()
    }
    
    //MARK: data methods
    //parse the JSON and style data
    func getLocalData() {
        
        //get url to JSON file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            //read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            //decode JSON into array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            //assign parsed modules to modules property
            self.modules = modules
        }
        catch {
            //log error
            print("Parsing local data failed")
        }
        
        //parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            //read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }
        catch {
            print("Parsing style data failed")
        }
    }
    
    //MARK: module navigation methods
    func beginModule(_ moduleId: Int){
        
        //find index
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                //found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        //set the current module
        currentModule = modules[currentModuleIndex]
    }
}
