// main.cpp

#include <iostream>
#include <vector>
#include <map>

class Person {
public:
    std::string name;
    unsigned int age;

public:    
    void greet() {
        std::cout 
            << "Hello, I am " << name 
            << ", and I am " << age 
            << " years old" << std::endl;
    }
};

int main(int argc, char**) {
    // Example 1
    std::string greet = "Hello world!";
    std::cout << greet << std::endl;
        
    // Example 2
    std::vector<std::string> colors = {
        "Green", "Blue", "Red"
    };
    for (auto it = colors.begin(); it != colors.end(); ++it) 
    {
        std::size_t idx = std::distance(colors.begin(), it);
        std::cout << "Color " << idx << " : " << *it << std::endl;
    }
    
    // Example 3
    std::map<std::string, int> groceries = {
        {"Apple", 12},
        {"Banana", 34},
        {"Cherry", 56}
    };
    for (auto it = groceries.begin(); it != groceries.end(); ++it) {
        std::size_t idx = std::distance(groceries.begin(), it);
        std::cout << "Item " << idx << " : " 
            << (*it).first << " => " 
            << (*it).second << "\n";
    }

    Person p1 = {"Logan", 24};
    p1.greet();
    
    return 0;
}
