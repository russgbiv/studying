//Accumulator Defines the entry point for the console
#include <string>
#include <iostream>
//#include "Person.h"
#include "Accum.h"

using namespace std;

int main()
{
  Accum<int> integers(0);
  integers += 3;
  integers += 7;
  cout << integers.GetTotal() << endl;
  
  Accum<string> strings("");
  strings += "hello";
  strings += " world";
  cout << strings.GetTotal() << endl;

  //integers += "testing"; //can't do this
  //strings += 4; //can't do this

  return 0;
}
