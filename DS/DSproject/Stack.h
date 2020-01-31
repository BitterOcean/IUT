#ifndef STACK_H
#define STACK_H

#include <iostream>
using namespace std;

class Stack;
class sNode {
	friend class Stack;
private:
	string bookName;
	int cost;
	sNode *next;
public:
	sNode(string n = "", int c = 0, sNode *l = 0);
	string getName();
	int getCost();
};

class Stack {
private:
	sNode *top;
	int size;
public:
	Stack();
	bool isEmpty();
	int getSize();
	void add(const string, const int);
	sNode* remove();
};

#endif //STACK_H