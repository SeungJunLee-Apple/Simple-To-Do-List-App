//
//  ContentView.swift
//  App1
//
//  Created by SeungJun Lee on 11/8/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoList.getAllToDoLists()) var toDoItems:FetchedResults<ToDoList>
    
    @State private var newToDoList = ""
    @State private var viewMode = 0
    
    var body: some View {
        VStack{
            
            GeometryReader { usa in
           
                
                
        VStack{
            Spacer()
            
            HStack{
            TextField("New Task", text: self.$newToDoList)
            Button(action:{
                
                let toDoItem = ToDoList(context: self.managedObjectContext)
                toDoItem.title = self.newToDoList
                toDoItem.createdAt = Date()
                toDoItem.taskIsDone = false
                
                
                //save to CoreData
                do {
                    try self.managedObjectContext.save()
                } catch{
                    print("Something went worng!")
                }
                
                //empty the string of newToDoItem
                self.newToDoList = ""
                
                
                
                
            }){
                Text("ADD")
            }
                
            }.frame(height: usa.size.height * 0.05)
            
            Spacer()
            //two button where user can select what list to watch: 'Remaining' or 'Done'
            HStack{
                Button(action:{
                    self.viewMode = 0
                }){
                    VStack{
                        Text("Remaining").fontWeight(.bold).foregroundColor(Color.white)
                    }.frame(width: usa.size.width * 0.4, height: usa.size.height * 0.07).background(self.viewMode == 0 ? Color.red : Color.red.opacity(0.5)).cornerRadius(20)
                }
                
                Button(action:{
                    self.viewMode = 1
                }){
                    VStack{
                        Text("Done").fontWeight(.bold).foregroundColor(Color.white)
                    }.frame(width: usa.size.width * 0.4, height: usa.size.height * 0.07).background(self.viewMode == 1 ? Color.green : Color.green.opacity(0.5)).cornerRadius(20)
                }
            }
            
           
            //list showing lists of task what user selected
            List{
                
                if self.viewMode == 0 {
                ForEach(self.toDoItems) { task in
                    if task.taskIsDone == false {
                        HStack{
                            
                            
                        Text("\(task.title ?? "Unkown")")
                            Spacer()
                            
                            Button(action:{
                                task.taskIsDone = true
                                
                                
                                do {
                                    try self.managedObjectContext.save()
                                } catch{
                                    print("Something went worng!")
                                }
                                
                                
                                
                            }){
                                Image(systemName: "circle")
                            }
                        }
                    }
                }
                }
                
                if self.viewMode == 1 {
                ForEach(self.toDoItems) { task in
    
                    
                    if task.taskIsDone == true {
                        
                        HStack{
                        Text("\(task.title ?? "Unkown")")
                            
                            Spacer()
                            
                            Button(action:{
                                task.taskIsDone = false
                                
                                
                                do {
                                    try self.managedObjectContext.save()
                                } catch{
                                    print("Something went worng!")
                                }
                                
                                
                            }){
                                Image(systemName: "circle")
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                }
            }
            
            
            
            
            
            
        }.frame(height: usa.size.height * 0.9)
        }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct selector: View{
    @Binding var viewMode:Int
    var body: some View {
        HStack{
            Button(action:{
                self.viewMode = 0
            }){
                Text("Remaining")
            }
            
            Button(action:{
                self.viewMode = 1
            }){
                Text("Done")
            }
        }
    }
}

