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
#include<string>
using namespace std;

int main() {
	ifstream rfile("c:/TestFile.txt");
	if (!rfile.is_open()) cout << "I can't open file for reading\n";
	else {
		string text;
		getline(rfile, text);
		cout << text << endl;
		rfile.close();
	}

	ofstream wfile("c:/TestFile.txt");
	if (!wfile.is_open()) cout << "I can't open file for writing\n";
	else {
		wfile << "I can write this new text";
		wfile.close();
	}
	getchar();
}