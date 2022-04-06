//
//  ContentView.swift
//  SwiftUITest
//
//  Created by 김효원 on 2019/10/29.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import SwiftUI
import Combine

struct SignView: View {
    private let genderType = ["남성","여성","비밀"]
    private let genderIcon = ["🙋🏻‍♂️","🙋🏻‍♀️","🦄"]
    
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var bornIn = 0
    @State private var gender = 0
    @State private var isAlertShow = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("이름")){
                    TextField("이름을 입력해주세요", text: $name)
                        .keyboardType(.default)
                }
                Section(header: Text("생년월일")){
                    Picker("출생년도", selection: $bornIn){
                        ForEach(1950 ..< 2019){
                            Text("\(String($0))년생")
                        }
                    }
                }
                Section(header: Text("성별")){
                    Picker("성별", selection: $gender){
                        ForEach(0 ..< self.genderType.count){
                            Text("\(self.genderType[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Button(action:{
                    self.isAlertShow = true
                    self.name = ""
                    self.bornIn = 0
                    self.gender = 0
                }){
                    Text("회원가입")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                }.alert(isPresented: $isAlertShow, content: {
                    Alert(title: Text("회원가입 성공"))
                })
                
            }.navigationBarTitle("\(name)님 환영합니다! \(genderIcon[gender])")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignView()
    }
}
