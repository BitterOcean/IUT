#ifndef LINKEDLIST_H
#define LINKEDLIST_H

#include <iostream>
#include <string>
#include <fstream>
#define RECORD "hi.txt"
using namespace std;

class LinkedList;
class lNode {
	friend class LinkedList;
private:
	string name;
	string auther;
	int year;
	int cost;
	lNode *next;
public:
	lNode(string n = "", string a = "", int y = 0, int c = 0);
	string getName();
	int getCost();
};

class LinkedList {
private:
	lNode *start, *New, *headNode;
	int size;
public:
	LinkedList();
	bool isEmpty();
	int getSize();
	void add(const string, const string, const int, const int);
	lNode *search(const string);
	int remove(const string);
	void sort();
	bool chap();
	void fPrint(fstream*);
	void fRead(fstream*);
	~LinkedList();
};

#endif // !LINKEDLIST_H
