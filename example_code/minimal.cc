// main.cc

#include <iostream>
#include <vector>
#include <memory>
#include <iterator>

// =============================================================================
// basic OOP test 

class Test {
private:
    // MEMBERS
    int a, b;
public:
    // CTOR
    Test();
    Test(int a, int b);
    
    // DTOR
    ~Test();

    // METHODS
    void run(void) const;
};

Test::Test() {
    this->a = 0;
    this->b = 0;
    std::cout << "Test() called." << std::endl; 
}
Test::Test(int a, int b) {
    this->a = a;
    this->b = b;
    std::cout << "Test(int, int) called." << std::endl; 
}
Test::~Test() {
    std::cout << "~Test() called." << std::endl; 
}
void Test::run(void) const {
    std::cout << "Test is running ..." << std::endl;
    if (a < b) {
        std::cout << a << " < " << b << std::endl;
    } 
    else if (a > b) {
        std::cout << a << " > " << b << std::endl;
    } 
    else {
        std::cout << a << " == " << b << std::endl;
    }
}

void ex1(void) {
    std::vector<std::unique_ptr<Test>> tests;
    tests.push_back(std::make_unique<Test>());
    tests.push_back(std::make_unique<Test>(2, 5));
    tests.push_back(std::make_unique<Test>(5, 2));
    tests.push_back(std::make_unique<Test>(4, 4));

    for(auto it = tests.begin(); it != tests.end(); ++it) {
        std::size_t idx = std::distance(tests.begin(), it);
        std::cout << "Testing item " << idx << " : ";
        (*it)->run();
    }
}

// =============================================================================
// some basic operations to test function pointer usage 

namespace operations {
int add(int a, int b) { 
    return a + b; 
}
int sub(int a, int b) { 
    return a - b; 
}
int product_of_two_operations( int a, int b, int(*fptr1)(int, int), int(*fptr2)(int, int)) {
    return fptr1(a, b) * fptr2(a, b);
}
} // operations

void ex2(void) {
    int a = 3, b = 4;
    
    int(*fptr1)(int, int) = &operations::add;
    auto fptr2 = &operations::sub;
        
    int r = operations::product_of_two_operations(a, b, fptr1, fptr2);
    std::cout << "a @ b = " << r << std::endl;
}

// =============================================================================
// main usage

int main(int argc, char *argv[]) {
    std::cout << "=== Hello world Example ===\nThis is hello world on another line." << std::endl;
    
    std::cout << "\n=== OOP Example ===" << std::endl;
    ex1();

    std::cout << "\n=== Fptr Example ===" << std::endl;
    ex2();
    
    return 0;
}
