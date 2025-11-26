#!/usr/bin/env python3
# python example 

from __future__ import annotations
import json

class Person:
    # class to represent a person

    def __init__(self, name_, age_) -> None:
        self.name = name_
        self.age = age_

    def to_str(self) -> str:
        return json.dumps(self.__dict__)


def main() -> None:
    # example using FF7 characters 

    names = ["Cloud", "Aerith", "Barret", "Tifa"]
    ages = [21, 22, 35, 20]

    people = []
    for name, age in zip(names, ages):
        my_person = Person(name, age)
        people.append(my_person)

    people.sort(key=lambda my_person: my_person.age)

    for my_person in people:
        print(my_person.to_str())

if __name__ == "__main__":
    main()

