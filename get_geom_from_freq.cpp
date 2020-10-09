#include <iostream>
#include <fstream>
#include <string>

int main(int argc, char *argv[])
{
    using namespace std;

    if (argv[1] != NULL) 
	{
		ifstream fin(argv[1], std::ios_base::in);
		string t;
		while (1)
		{
			getline(fin, t);
			if ((t.find("FINAL ENERGY")) != string::npos)	break;
		}
		for (int i=0; i<5; i++)
		{
			getline(fin, t);
		}
		getline(fin, t);
		t = t.substr(5);
		while (1)
		{
			getline(fin, t);
			if ((t.find("----")) != string::npos)   break;
            if (t.length() < 1)  break;
			cout << t << endl;
		}
		return 0;
	}
	return 0;
}