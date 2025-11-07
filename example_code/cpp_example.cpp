// cpp syntax example

#include <string>
#include <iostream>
#include <vector>

class Person {
public:
    std::string name;
    int age;
public:
    Person() = default;
    void greet();
};

void Person::greet() {
    std::cout << "Hello, my name is " << name << ", and I am " << age << " years old." << std::endl;
}

int main(int argc, char** argv) {
    /* Block comment. Example showcasing different syntax highlighting. */

    // Namespace syntax. Any words containing :: will be highlighted.
    std::vector<Person> people = {
        {"Alice", 11}, // string and value syntax
        {"Bob", 22},
        {"Claire", 33}
    };
    
    // Keyword syntax
    for (auto it = people.begin(); it != people.end(); ++it) {
        (*it).greet();
    }

    return 0;
}
