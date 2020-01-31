/*
Project : BookStore
in cpp
Data Structure (97-1)

Authers :
	Zahra Khoramian , Maryam Saeedmehr  

Teacher : Dr. Mirzaee

DeadLine :  20th Azar_97 Tue.
*/

#include "Stack.h"
#include "LinkedList.h"
#include "Human.h"
#include <Windows.h>

// forward decleration
void menu();
void MainMenu();
void SwitchCase(int);
void case1();
void case2();
void case3();
void case4();
void Loading();
void setTextColor(int textColor, int backColor = 0);
//-------------------------------------
//-------------------------------------
//-------------------------------------
//-------------------------------------
/*	Global Options	*/
LinkedList BookStore;
Human People;

int main() 
{
	setTextColor(11);
	MainMenu();
	return 0;
}
//-------------------------------------
//-------------------------------------
//-------------------------------------
//-------------------------------------
void menu()
{
	system("cls");
	cout << "Please choose one among these servises : \n\n";
	cout << "1- Login and complete your information\n";
	cout << "2- Choose your books\n";
	cout << "3- Add a book to the bookstore\n";
	cout << "4- Show your bill\n";
	cout << "5- Exit\n";
}

void MainMenu()
{
	/*---------Main Menu---------*/
	int choice;
	menu();
	cin >> choice;
	while (choice != 5)
	{
		SwitchCase(choice);
		menu();
		cin >> choice;
	}
	/*---------Main Menu---------*/
	cout << "\nBYE :(\t\n";
	Sleep(2000);
}

void SwitchCase(int choice) 
{
	switch (choice)
	{
	case 1:
		case1();
		return;

	case 2:
		case2();
		return;

	case 3:
		case3();
		return;

	case 4:
		case4();
		return; 

	default:
		cout << "Unknown choice :/\n";
		return;
	}
}

void case1()
{
	/*
		Login
		and complete your information
	*/
	system("cls");
	string name, lname ; 
	int gender;
	cout << "* Please complete this form : \n";
	cout << "1- What's your name ? Your answer : ";
	cin >> name;
	cout << "2- What's your last name ? Your answer : ";
	cin >> lname;
	if (People.getSize() && People.search(name, lname)!=NULL)
	{
		cout << "\nYou are already Logedin! \n";
		cout << "Press any key to go back to main menu\n";
		getchar();
		getchar();
		return;
	}
	cout << "3- You are a (Female / male) ?( NOTE !: Insert 0 for male and 1 otherwise) Your answer : ";
	cin >> gender;

	People.add(name, lname, gender);
	
	system("cls");
	cout << "Welcome " << name << " " << lname << " to this book store...\n\n";
	cout << "Press any key to go back to main menu\n";
	getchar();
	getchar();
	return;
}

void case2()
{
	/*
		choose your books
	*/
	system("cls");
	string fname, lname;
	cout << "Please enter your name ? answer : "; cin >> fname;
	cout << "Please enter your last name ? answer : "; cin >> lname;
	hNode *person = People.search(fname, lname);
	Loading();
	if (person == NULL)
	{
		cout << "\nThis person is not loggedin in this bookstore!\n";
		cout << "Press any key to go back to main menu\n";
		getchar();
		getchar();
		return;
	}

	string book;
	cout << "Which book do you want to buy ?\n";
	cout << "( NOTE !: please enter the name of the book you want from the list below\n";
	cout << "And also insert '0' to finish choosing book )\n\n";
	if (!BookStore.chap())
	{
		cout << "Press any key to come back to the main menu\n";
		getchar();
		getchar();
		return;
	}
	
	while (cin >> book)
	{
		if (book == "0")
			break;

		lNode *ptr = BookStore.search(book);
		if (ptr != NULL)
		{
			person->Buy(book, ptr->getCost());
			cout << "Successfuly done !\n";
			Sleep(1000);
			BookStore.remove(book);
			system("cls");
			if (!BookStore.isEmpty())
			{
				cout << "Which book do you want to buy ?\n";
				cout << "( NOTE !: please enter the name of the book you want from the list below\n";
				cout << "And also insert '0' to finish choosing book )\n\n";
			}
			if (!BookStore.chap())
			{
				cout << "Sorry now there is no more book for sale\n";
				cout << "Press any key to come back to the main menu\n";
				getchar();
				getchar();
				return;
			}
		}
		else
			cout << "This book is not found in this book store !\n";
	}
	return;
}

void case3()
{
	/*
		Add a book to the bookstore

		a book needs a 'name' , 'auther' , 'year' , 'cost' ;
	*/
	system("cls");
	string name, auther;
	int year, cost;
	cout << "What's the name of this new book ? : ";
	cin >> name;
	cout << "What's the auther of this new book ? : ";
	cin >> auther;
	cout << "In which year it is published ? : ";
	cin >> year;
	cout << "How much does it cost ? : ";
	cin >> cost;
	BookStore.add(name, auther, year, cost);
	cout << "Well Done !\n";
	cout << "Press any key to continue ";
	getchar();
	getchar();
	return;
}

void case4()
{
	/*
		Show your bill
	*/
	system("cls");
	if (People.isEmpty())
	{
		cout << "There is not anyone in the bookstore !!\n";
		cout << "Press any key to continue ";
		getchar();
		getchar();
		return;
	}
	string fname, lname;
	cout << "Please enter your name ? answer : "; cin >> fname;
	cout << "Please enter your last name ? answer : "; cin >> lname;
	hNode *person = People.search(fname, lname);
	Loading();
	if (person != NULL)
		People.remove(person->getTurn());
	else
	{
		cout << "Sorry ! This person is not here !\n";
		cout << "Press any key to continue ";
		getchar();
		getchar();
		return;
	}
}

void Loading()
{
	system("cls");
	cout << "Loading.";
	Sleep(500);
	system("cls");
	cout << "Loading..";
	Sleep(500);
	system("cls");
	cout << "Loading...";
	Sleep(600);
	system("cls");
}

void setTextColor(int textColor, int backColor)
{
	HANDLE consoleHandle = GetStdHandle(STD_OUTPUT_HANDLE);
	int colorAttribute = backColor << 4 | textColor;
	SetConsoleTextAttribute(consoleHandle, colorAttribute);
}
