#include "LinkedList.h"

lNode::lNode(string n, string a, int y, int c): name(n), auther(a), year(y), cost(c) {}

string lNode::getName() { return name; }

int lNode::getCost() { return cost; }

LinkedList::LinkedList() 
{
	headNode = new lNode();
	start = headNode;
	size = 0; 
	fstream *file = new fstream(RECORD, ios::in | ios::out | ios::app);
	this->fRead(file);
	file->close();
}

bool LinkedList::isEmpty() { return start == headNode; }

int LinkedList::getSize() { return size; }

void LinkedList::add(const string n, const string a, const int y, const int c)
{
	New = new lNode(n, a, y, c);
	New->next = headNode;
	if (start == headNode)
		headNode->next = New;
	start->next = New;
	start = New;
	size++;
}

lNode *LinkedList::search(const string n)
{
	lNode *ptr = headNode;
	for (; ptr->next != headNode; ptr = ptr->next)
	{
		if (ptr->next->name == n) {
			return ptr->next;
		}
	}
	return NULL;
}

int LinkedList::remove(const string n)
/*
this function will remove a node by searching
the name of the wanted book...
it will return -1 as removal failure and 1 o.w.
*/
{
	lNode *ptr = headNode;
	lNode *temp;
	for (; ptr->next != headNode; ptr = ptr->next)
	{
		if (ptr->next->name == n) {
			temp = ptr->next;
			ptr->next = temp->next;
			delete temp;
			size--;
			if(size==0)
				start = headNode;
			return 1;
		}
	}
	return -1;
}

void LinkedList::sort()
{
	lNode *ptr = headNode->next;
	lNode *ptr1 = headNode->next->next;
	for (; ptr->next != headNode; ptr = ptr->next)
	{
		for (; ptr1->next != headNode; ptr1 = ptr1->next)
		{
			if (ptr->name < ptr1->name)
			{
				lNode *temp = new lNode(ptr->name, ptr->auther, ptr->year, ptr->cost);
				ptr->name = ptr1->name;
				ptr->auther = ptr1->auther;
				ptr->year = ptr1->year;
				ptr->cost = ptr1->cost;
				ptr1->name = temp->name;
				ptr1->auther = temp->auther;
				ptr1->year = temp->year;
				ptr1->cost = temp->cost;
				delete temp;
			}
			else if (ptr->name == ptr1->name)
			{
				if (ptr->year < ptr1->year)
				{
					lNode *temp = new lNode(ptr->name, ptr->auther, ptr->year, ptr->cost);
					ptr->name = ptr1->name;
					ptr->auther = ptr1->auther;
					ptr->year = ptr1->year;
					ptr->cost = ptr1->cost;
					ptr1->name = temp->name;
					ptr1->auther = temp->auther;
					ptr1->year = temp->year;
					ptr1->cost = temp->cost;
					delete temp;
				}
			}
		}
	}
}

bool LinkedList::chap()
{
	/*
		this function will return 'true' if
		it work properly , mean that there
		is any book in the book store to 
		be printed
		and will return 'false' if the book
		store is empty :/
	*/
	if (!isEmpty()) 
	{
		sort();
		lNode *ptr = headNode->next;
		cout << "  Name\t" << "Auther\t" << "Year\t" << "Cost\n";
		cout << "----------------------------------\n";
		for (int i = 1; ptr != headNode; ptr = ptr->next, i++)
			cout << i << "- " << ptr->name << "\t" << ptr->auther << "\t" << ptr->year << "\t" << ptr->cost << endl;
		return true;
	}
	cout << "Sorry ! Now we have no book for sale ! please come again another day !\n";
	return false;
}

void LinkedList::fPrint(fstream *file)
{
	lNode *ptr;
	if (size)
		for (ptr = headNode->next; ptr != headNode; ptr = ptr->next)
			*file << ptr->name << " " << ptr->auther << " " << ptr->year << " " << ptr->cost << endl;
		
	file->flush();
}

void LinkedList::fRead(fstream *file)
{
	int year, cost;
	string name, author;
	while (file->peek()!= EOF)
	{
		*file >> name >> author >> year >> cost;
		file->get();
		this->add(name, author, year, cost);
	}
}

LinkedList::~LinkedList()
{
	fstream *file = new fstream(RECORD, ios::out | ios::trunc);
	file->clear();
	this->fPrint(file);
	file->close();
	getchar();
	getchar();
}