// db_1.2.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

using namespace std;

void ReadFile(ifstream &input, vector<string> &records)
{
	string line;
	istringstream inputLine;
	getline(input, line);
	while (getline(input, line))
	{
		records.push_back(line);
	}
}

void FindAuthorAndPrintId(vector<string> &records, string author)
{
	string id;
	for (auto it = records.begin(); it != records.end(); ++it)
	{
		size_t namePos = it->find(author);
		if (namePos != string::npos)
		{
			size_t separator = it->find(",");
			id = it->substr(0, separator);
			cout << id << ", ";
		}
	}
}

int main()
{
	ifstream input("db.csv");
	vector<string> records;
	ReadFile(input, records);
	
	string author = "";

	while (true)
	{
		cout << "Enter author name: ";
		cin >> author;
		if (author == "")
		{
			return 1;
		}
		cout << "id: ";
		FindAuthorAndPrintId(records, author);
		cout << endl;
	}
    return 0;
}

