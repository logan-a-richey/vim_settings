// main.cpp

#include <iostream>
#include <string>
#include <cstdint>
#include <sstream>
#include <vector>

class Person 
{
public:
    std::string name;
    unsigned int age;
public:
    std::string to_str(void);
};

std::string Person::to_str(void)
{
    std::ostringstream oss;
    oss << "{\"name\": \"" << name << "\", \"age\": " << age << "}";
    return oss.str();
}

int main(int argc, char *argv[]) 
{
    std::vector<Person> people;
    people.push_back({"Alice", 11});
    people.push_back({"Bobby", 22});
    people.push_back({"Cindy", 33});
    
    for (auto it = people.begin(); it != people.end(); ++it) 
    {
        std::cout << (*it).to_str() << std::endl;
    }
    return 0;
}
