// title
/* block */

#include <iostream>
#include <string>
#include <vector>

// macro test
#define NUMBER 10

// template test 
template<typename T>
void print_vector(std::vector<T>& v) {
    for (const auto& e : v) {
        std::cout << e << " ";
    }
    std::cout << std::endl;
}

// inheritance test
class Animal {
public:
    virtual void make_sound() = 0;
    virtual ~Animal() = default;
};

class Dog : public Animal {
public:
    void make_sound() override {
        std::cout << "Bark!" << std::endl;
    }
};

class Cat : public Animal {
public:
    void make_sound() override {
        std::cout << "Meow!" << std::endl;
    }
};

int main(int argc, char** argv) {
    std::cout << "--- C++ syntax test ---\n"; 

    // basic loop test
    for (int i = 0; i < 20; ++i) {
        std::cout << "\n";
        std::cout << "i = " << i << " ";
        if (i % 3 == 0) { std::cout << "Fizz"; }
        if (i % 5 == 0) { std::cout << "Buzz"; }
        if (i == 7) continue;
        if (i == 10) break;
    }

    // template test
    std::cout << "\n";
    std::cout << "--- Vector Test ---\n";
    std::vector<int> nums = {1, 2, 3, 4, 5};
    std::vector<std::string> words = {"Hello", "there!", "...General", "Kenobi"};
    print_vector(nums);
    print_vector(words);

    // oop test
    std::cout << "\n";
    std::cout << "--- OOP Test ---\n";
    Dog d;
    Cat c;
    d.make_sound();
    c.make_sound();
    
    std::cout << "\n";
    std::cout << "Macro number: " << NUMBER << std::endl;
    return 0;
}
