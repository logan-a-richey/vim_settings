#!/usr/bin/env python3
# python_example.py

from __future__ import annotations
from typing import List
from abc import (ABC, abstractmethod)

class AbstractPerson(ABC):
    ''' Person interface class '''
    
    def __init__(self, name_: str, age_: int):
        self.name = name_
        self.age = age_
    
    @abstractmethod
    def greet(self):
        raise NotImplementedError


class Person(AbstractPerson):
    ''' Concrete Person class '''

    def __init__(self, name_: str, age_: int):
        super().__init__(name_, age_)

    def greet(self):
        print("Hello, my name is {} and I am {} years old.".format(self.name, self.age))


def main():
    ''' Example code '''

    # list of People objects
    people: List[People] = [
        Person("Alice", 11), 
        Person("Bob", 22), 
        Person("Claire", 33)
    ]
    
    # print each person's data:
    for person in people:
        person.greet()

if __name__ == "__main__":
    main()


