//http://www.mathcs.emory.edu/~cheung/Courses/323/Syllabus/Map/skip-list-impl.html
//very good link to learn about skiplists...
#include <iostream>
#include <string>
#include <ctime>
using namespace std;
class SkipList;
string negInf = "-oo";  // -inf key value
string posInf = "+oo";  // +inf key value
class SkipListEntry
{
	friend class SkipList;
	string key;
	int value;
	SkipListEntry *up;       // up link
	SkipListEntry *down;     // down link
	SkipListEntry *left;     // left link
	SkipListEntry *right;    // right link        
	
public :
	SkipListEntry(string);

};

SkipListEntry::SkipListEntry(string inf) : key(inf) {
	if (inf == "+oo") right = NULL;
	else left = NULL;
}

class SkipList
{
	SkipListEntry *head;		// First element of the top level
	SkipListEntry *tail;		// Last element of the top level
	int n;				    // number of entries in the Skip List   
	int h;					// Height
	Random r;			// Coin toss
	
public :
	SkipList();
	SkipListEntry* findEntry(string);
	int get(string);

};

SkipList::SkipList() {
	SkipListEntry *p1, *p2;

	/* -----------------------------------
	   Create an -oo and an +oo object
   ----------------------------------- */
	p1 = new SkipListEntry(negInf);
	p2 = new SkipListEntry(posInf);


	/* --------------------------------------
	   Link the -oo and +oo object together
   --------------------------------------- */
	p1->right = p2;
	p2->left = p1;

	/* --------------------------------------
	   Initialize "head" and "tail"
   --------------------------------------- */
	head = p1;
	tail = p2;

	/* --------------------------------------
	   Other initializations
   --------------------------------------- */
	n = 0;                   // No entries in Skip List
	h = 0;		      // Height is 0

	r = new Random();	      // Make random object to simulate coin toss
}

/* ------------------------------------------------------
   findEntry(k): find the largest key x <= k
				 on the LOWEST level of the Skip List
   ------------------------------------------------------ */

SkipListEntry* SkipList::findEntry(string k)
{
	SkipListEntry *p;

	/* -----------------
	   Start at "head"
	   ----------------- */
	p = head;

	while (true)
	{
		/* ------------------------------------------------
		   Search RIGHT until you find a LARGER entry

		   E.g.: k = 34

					 10 ---> 20 ---> 30 ---> 40
									  ^
									  |
									  p must stop here
		p.right.key = 40
		   ------------------------------------------------ */
		while ((p->right->key) != posInf && stoi(p->right->key)-stoi(k) <= 0)
		{
			p = p->right;         // Move to right
		}

		/* ---------------------------------
		   Go down one level if you can...
		   --------------------------------- */
		if (p->down != NULL)
		{
			p = p->down;          // Go downwards
		}
		else
		{
			break;       // We reached the LOWEST level... Exit...
		}
	}

	return(p);         // Note: p.key <= k
}

int SkipList::get(string k)
{
	SkipListEntry *p;

	p = findEntry(k);

	if (k == p->key)
		return(p->value);
	else
		return(NULL);
}