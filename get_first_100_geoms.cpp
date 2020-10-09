#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>

int main()
{
    using namespace std;

    fstream fin("isomers.xyz", ios_base::in);
    fstream fout("isomers100.xyz", ios_base::out);

    size_t sz;
    string t;
    getline(fin, t);
    int nAtoms = stoi(t, &sz);
    streampos geom_size = fin.tellg();
    const streampos first_line_size = geom_size;
    getline(fin, t);
    const streampos second_line_size = fin.tellg() - first_line_size;
    streampos changeg;
    while (true)
    {
        getline(fin, t);
        changeg = fin.tellg() - geom_size;
        if (first_line_size == changeg) break;
        geom_size = fin.tellg();
    }

    fin.seekg(0, fin.end);
    streampos endpos = fin.tellg();
    int nGeoms = (int)endpos / (int)geom_size;
    cout << nGeoms << " Geomertories were found, with " << nAtoms << " atoms per geom.\n";

    vector<double> energy;
    fin.seekg(first_line_size);
    for (int i = 0; i < nGeoms; i++)
    {
        getline(fin, t);
        energy.push_back(stod(t.substr(10).substr(4, 10)));
        fin.seekg(-second_line_size, ios_base::cur);
        if (((int)fin.tellg() + (int)geom_size) < (int)endpos) fin.seekg(fin.tellg() + geom_size);
    }

    char* buffer = new char[geom_size];
    for (int i = 0; i < 100; i++)
    {
        int index_to_retrive = min_element(energy.begin(),energy.end()) - energy.begin();
        energy[index_to_retrive] = 1;
        // random access to isomers.xyz
        fin.seekg(index_to_retrive * geom_size);
        fin.read(buffer, geom_size);
        fout.write(buffer, geom_size);
    }
    delete[] buffer;
    fin.close();
    fout.close();
    
    return 0;
}