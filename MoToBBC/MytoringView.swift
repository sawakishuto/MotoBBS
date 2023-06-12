//
//  MytoringView.swift
//  MoToBBC
//
//  Created by 澤木柊斗 on 2023/05/16.
//



import SwiftUI
import FirebaseFirestore
import Firebase
import FirebaseAuth

struct MytoringView: View {
    @State private var userInfoArray: [[String]] = []
    @State var messa = "ツーリング終了！"
    @ObservedObject private var viewModel = ViewModel()
   
    @State  var datamodel = ViewModel().datamodel
    @State var isgo = false
    @State var pp:Int = 0
    @State var uid:String = ""
    @State var documentId = ""
    
   
    let eventid:String
    let  whereis:String
    let detail:String
    let title:String
    let dateString:String
    let how:String
    init(eventid:String,whereis:String,detail:String,title:String,dateStrig:String,how:String){
        self.eventid = eventid
        self.whereis = whereis
        self.detail = detail
        self.title = title
        self.dateString = dateStrig
        self.how = how
     
    }
  
    var body: some View {
        
        VStack{
        
                Text(title).font(.title).fontWeight(.bold)
                Spacer()
                
                
                
                Text("開催予定日:" + dateString)
                
                Divider().background(Color.red)
                
                Text("出発地:" + whereis)
                Text("詳細:" + detail)
                Text("参加予定者").foregroundColor(.red)
                    .fontWeight(.bold)
            VStack{
                List(userInfoArray, id: \.self) { userInfo in
                    Text("名前: \(userInfo[0])\n車種: \(userInfo[2])\n性別: \(userInfo[1])　")
                }.listStyle(PlainListStyle()) // リストのスタイルをプレーンに設定
                    .background(Color.white)
                    .frame(height: 300)
            }
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
            
            Text(messa)
                .frame(width: 190,height: 60)
                .background(Capsule().fill( Color(red: 50, green: 10 / 255, blue: 10 / 255)))                    .shadow(color: .gray, radius: 3, x: 3, y: 3)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                .onTapGesture {
                self.viewModel.deleteDocument()
                                self.isgo.toggle()
                if isgo == true{
                    self.viewModel.AttendListclear(eventid: self.eventid)
                   self.viewModel.getUser()
                   messa = "お疲れ様でした！"
                    
                }
            }
        }
        .onAppear(){
            
            self.viewModel.fetchUserInfoFromAttendList(documentinfo: self.eventid) { userInfoArray in
                self.userInfoArray = userInfoArray
            }
            
            self.viewModel.getUser()
        }
            
           
          
        }
        }
    
    

struct MytoringView_Previews: PreviewProvider {
    static var previews: some View {
       MytoringView(eventid: "現在募集中のツーリングはありません", whereis: "1", detail: "", title: "", dateStrig: "", how: "")
    }
}
