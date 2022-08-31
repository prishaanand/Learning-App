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
    
    //keep track of selected question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    //current lesson explanation
    @Published var codeText = NSAttributedString()
    
    //current selected content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int? 
    
    init() {
        //parse local included json data
        getLocalData()
        //download remote json file + parse data
        getRemoteData()
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
    
    //download remote JSON + parse
    func getRemoteData() {
        
        //string path
        let urlString = "https://prishaanand.github.io/LearningApp-Data/data2.json"
        
        //create a url object
        let url = URL(string: urlString)
        
        guard url != nil else {
            //couldnt create url
            return
        }
        
        //create a url request object
        let request = URLRequest(url: url!)
        
        //get the session & kick of the task
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            //check if there is an error
            guard error == nil else {
                //error found
                return
            }
            
            do {
                //create json decoder
                let decoder = JSONDecoder()
                //decode
                let modules = try decoder.decode([Module].self, from: data!)
                
                //improve speed
                DispatchQueue.main.async {
                    //append parsed modules into modules property
                    self.modules += modules
                }
            }
            catch {
                //couldnt parse json
                
            }
            
            
        }
        
        //kick of the dataTask
        dataTask.resume()
        
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
        //set explanation for that lesson
        codeText = addStyling(currentLesson!.explanation)
        
    }
    
    func nextLesson() {
        //advance the lesson index
        currentLessonIndex += 1
        
        //check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            //set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            //set explanation for that lesson
            codeText = addStyling(currentLesson!.explanation)
        }
        else {
            //out of range, reset lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
        
    }
    
    //check if current lesson has a following lesson, else it is the last lesson
    func hasNextLesson() -> Bool {
        
        guard currentModule != nil else {
            return false
        }
        
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            return true
        }
        else {
            return false
        }
    }
    
    //set the current module + question
    func beginTest(_ moduleId:Int) {
        
        beginModule(moduleId)
        currentQuestionIndex = 0
        
        //set current question to first one, if there are q's
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule?.test.questions[currentQuestionIndex]
            //set the content question as well
            codeText = addStyling(currentQuestion!.content)
        }
        
    }
    
    func nextQuestion() {
        
        //advance the question index
        currentQuestionIndex += 1
        
        //check that its within range of questions
        if currentQuestionIndex < currentModule!.test.questions.count {
            
            //set the current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        
        //else, reset properties
        else{
            currentQuestionIndex = 0
            currentQuestion = nil
        }
        
    }
    
    //MARK: Code Styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultsString = NSAttributedString()
        var data = Data()
        
        //add the styling data
        if styleData != nil {
            data.append(self.styleData!)
        }
       
        //add the html data
        data.append(Data(htmlString.utf8))
        
        //convert to attributed string
        do {

            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                
            resultsString = attributedString
            
        }
        catch {
            print("Couldn't turn html into attributed string")
        }
        
        return resultsString
    }
}
