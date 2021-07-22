/*
    # Computer Security Course 3992

    # Question 7 ? ------------------------------
        Access Control

    # Who am I ? --------------------------------
        Author : Maryam Saeedmehr
        Std.NO : 9629373
*/
#include<iostream>
#include<fstream>
using namespace std;

int main() {
	ofstream wfile("c:/TestFile.txt");
	if (!wfile.is_open()) cout << "I can't open file for writing\n";
	else {
		wfile << "I am user User1. I can write";
		wfile.close();
	}
	ifstream rfile("c:/TestFile.txt");
	if (!rfile.is_open()) cout << "I can't open file for reading\n";
	system("pause");
	return 0;
}