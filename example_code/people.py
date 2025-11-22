#!/usr/bin/env python3

import json

class Person:
    def __init__(self, name_: str, age_: int):
        self.name = name_
        self.age = age_
    
    def to_str(self) -> str:
        return json.dumps(self.__dict__)

def main():
    people = [
        Person("Alice", 11),
        Person("Bobby", 22),
        Person("Cindy", 33)
    ]

    for p in people:
        print(p.to_str())

if __name__ == "__main__":
    main()

