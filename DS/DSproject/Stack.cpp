#include "Stack.h"

sNode::sNode(string n , int c, sNode *l) : next(l), bookName(n), cost(c) {}

string sNode::getName() { return bookName; }

int sNode::getCost() { return cost; }

Stack::Stack() : top(0), size(0) {}

bool Stack::isEmpty() { return top == NULL; }

int Stack::getSize() { return size; }

void Stack::add(const string n, const int c)
{
	top = new sNode(n, c, top);
	size++;
}

sNode* Stack::remove()
/*
this function will return 'NULL' as failure
and the cost of the book o.w....
*/
{
	if (top == NULL) return NULL;
	sNode *temp = top;
	top = temp->next;
	size--;
	return temp;
}