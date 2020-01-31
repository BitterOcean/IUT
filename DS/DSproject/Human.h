#ifndef HUMAN_H
#define HUMAN_H

#include "Stack.h"
#include <string>

class hNode
{
	friend class Human;
	string fname, lname;
	bool gender;
	int turn;
	Stack ShoppingBag;
	hNode *next;
public :
	hNode(string, string, bool);
	void PrintBill();
	void Buy(const string, const int);
	int getTurn();
};

class Human
{
	int counter;
	int NumberOfHuman;
	bool flag;//to show gender for next turn ,0 for men and 1 for women
	hNode *first, *last;
public:
	Human();
	hNode* add(string,string,bool);
	void remove(int);
	hNode* search(string, string);
	int getSize();
	bool isEmpty();
};

#endif //HUMAN_H