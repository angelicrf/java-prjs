package com.company;
import com.company.AuthorInfo;

public class Main extends AuthorInfo{

    Main(String newName, int newExp) {
        super(newName, newExp);
    }
    Main(){}
    public static void main(String[] args) {

        System.out.println("some texts");
        Main mn = new Main();
        mn.getInfo();
        //AuthorInfo authorInfo = new AuthorInfo();
        //super.displayInfo();
    }
    void getInfo(){
        String hlName = super.getMyName();
        int hlExp = super.getMyExp();
        System.out.println("her Name is " +  hlName + "Exp is " + hlExp);
    }
}
