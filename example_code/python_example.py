#!/usr/bin/env python3

# Comment

from abc import (ABC, abstractmethod)

class AbstractPerson(ABC):
    ''' Docstring '''
    def __init__(self, name: str, age: int):
        self.name = name
        self.age = age
    
    @abstractmethod
    def greet(self):
        raise NotImplementedError

class Person(AbstractPerson):
    def __init__(self, name: str, age: int):
        super().__init__(name, age)

    def greet(self):
        print("Hello, my name is {} and I am {} years old.".format(self.name, self.age))

def main():
    people = [
        Person("Alice", 11), 
        Person("Bob", 22), 
        Person("Claire", 33)
    ]
    
    for person in people:
        person.greet()

if __name__ == "__main__":
    main()


