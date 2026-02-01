:colo	// main.cpp
// cpp example

// import statements
#include <iostream>
#include <vector>
#include <string>
#include <sstream>

class Person {
public:
    std::string name;
    unsigned int age;
public:
    Person() = delete;
    Person(const std::string& n, int a);
    ~Person();
    std::string to_str(void) const;
};

Person::Person(const std::string& n, int a) {
    std::cout << "Person CTOR called." << std::endl;
    this->name = n;
    this->age = a;
}

Person::~Person() {
    std::cout << "Person DTOR called." << std::endl;
}
std::string Person::to_str(void) const {
    std::ostringstream oss;
    oss << "{" << "\"name\": " << name << ", \"age\": " << age << "}";
    return oss.str();
}

int main() {
    std::vector<Person> people;
    people.push_back({"Tifa", 20});
    people.push_back({"Cloud", 21});
    people.push_back({"Aerith", 22});
    people.push_back({"Barret", 35});
    
    for (const auto& p : people) {
        std::cout << p.to_str() << std::endl;
    }

    return 0;
}
