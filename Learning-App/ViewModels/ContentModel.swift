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
    
    //keep track of selected lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
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
    
    func beginLesson(_ lessonIndex:Int){
        
        //check lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        
        //set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
    }
    
    func nextLesson() {
        //advance the lesson index
        currentLessonIndex += 1
        
        //check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            //set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        }
        else {
            //out of range, reset lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
        
    }
    
    //check if current lesson has a following lesson, else it is the last lesson
    func hasNextLesson() -> Bool {
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            return true
        }
        else {
            return false
        }
    }
    
}
