#! /usr/bin/env bash

# Create new file with name
if [ $# -eq 1 ]
then
    filename="$1"
else 
    filename="$(date +%Y%m%d)_"
fi

touch $filename.cc

cat <<EOF >>$filename.cc
#include <iostream>
using namespace std;

// make the testing framework print out vector values
template <typename T>
ostream& operator<<(ostream& os, const vector<T>& v) {
    os << "{";
    for (size_t i = 0; i < v.size(); ++i) {
        os << v[i];
        if (i + 1 < v.size()) os << ", ";
    }
    os << "}";
    return os;
}


// ==================================================

#ifdef LOCAL_TESTING

#define DOCTEST_CONFIG_IMPLEMENT
#include "doctest.h"
#define tc TEST_CASE
#define check CHECK


tc("stub test"){
    check(true);
}

int main(){
    doctest::Context context;
    int test_result = context.run();
    if(context.shouldExit()) return test_result;
    return 0;
}

#else
// ==================================================

int main() {
    return 0;
}

#endif
EOF


