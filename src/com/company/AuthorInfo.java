package com.company;

public class AuthorInfo {
    String myName = "Angelique";
    int myExp = 9 ;
    AuthorInfo(){}
    AuthorInfo(String newName,int newExp){
        this.myName = newName;
        this.myExp = newExp;

    }
    public void displayInfo(){
        System.out.println(this.myName + this.myExp);
    }

    public String getMyName() {
        return myName;
    }

    public int getMyExp() {
        return myExp;
    }
}
