#include "Human.h"

hNode::hNode(string fname, string lname, bool gender) :fname(fname), lname(lname), gender(gender), next(NULL) {}

void  hNode::PrintBill()
{
	sNode *temp = ShoppingBag.remove();
	int TotalPrice = 0;
	if (temp)
	{
		int counter = 1;
		cout << " Name\t" << "Cost\n";
		cout << "-------------\n";
		while (temp)
		{
			cout << counter << "- " << temp->getName() << "\t" << temp->getCost() << endl;
			TotalPrice += temp->getCost();
			delete temp;
			temp = ShoppingBag.remove();
			counter++;
		}
	}
	else
		cout << "There is no book in your shopping bag\n";
	cout << "Total Price : " << TotalPrice << " $.\n";
}

void hNode::Buy(const string name, const int cost) { ShoppingBag.add(name, cost); }

int hNode::getTurn() { return turn; }

Human::Human() :counter(0), flag(0), NumberOfHuman(0) {}

hNode* Human::add(string fname, string lname, bool gender)
{
	if (NumberOfHuman)
	{
		last->next = new hNode(fname, lname, gender);
		last = last->next;
	}
	else
	{
		first = new hNode(fname, lname, gender);
		last = first;
	}
	last->turn = ++counter;
	NumberOfHuman++;
	return last;
}

void Human::remove(int turn)
{
	hNode *previous = first, *temp;
	for (temp = first; temp && temp->gender != flag; temp = temp->next)
		previous = temp;
	if (!temp)
		for (temp = first; temp && temp->gender == flag; temp = temp->next);
	if (temp->turn == turn)
	{
		if (temp->gender == flag) flag = !flag;
		if (temp == first)
		{
			temp->PrintBill();
			first = first->next;
			cout << "\nPress any key to continue ";
			getchar();
			getchar();
		}
		else if (temp == last)
		{
			temp->PrintBill();
			previous->next = NULL;
			last = previous;
			cout << "\nPress any key to continue ";
			getchar();
			getchar();
		}
		else
		{
			temp->PrintBill();
			previous->next = temp->next;
			cout << "\nPress any key to continue ";
			getchar();
			getchar();
		}
		delete temp;
		NumberOfHuman--;
	}
	else
	{
		cout << "\nIt's not your turn ! Please try later\n";
		cout << "Press any key to continue ";
		getchar();
		getchar();
	}
}

hNode* Human::search(string fname, string lname)
{
	hNode* temp;
	for (temp = first; temp && (temp->fname != fname || temp->lname != lname); temp = temp->next);
	if (temp)
		return temp;
	return NULL;
}

int Human::getSize() { return NumberOfHuman; }

bool Human::isEmpty() { return NumberOfHuman == 0; }