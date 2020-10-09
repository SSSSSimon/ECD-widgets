#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>
#include <math.h>
int main(int argc, char *argv[])
{
	using namespace std;


	if (argv[1] != NULL) 
	{
		ifstream fin(argv[1], std::ios_base::in);
		ifstream fin2(argv[2], std::ios_base::in);
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
		size_t sz;
		double C1[3] = {stod(t, &sz), stod(t.substr(sz)), stod(t.substr(sz).substr(sz))};
		
		while (1)
		{
			getline(fin2, t);
			if ((t.find("xyz")) != string::npos)	break;
		}
		getline(fin2, t);
		t = t.substr(8);
		double C2[3] = {stod(t, &sz), stod(t.substr(sz)), stod(t.substr(sz).substr(sz))};
		if (fabs(C1[0]-C2[0]) < 0.00001 || fabs(C1[1]-C2[1]) < 0.00001 || fabs(C1[2]-C2[2]) < 0.00001)
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	return 0;
}
