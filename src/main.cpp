#include "external.hpp"
#include <cstddef>
#include <iostream>
#include <string>
#include <regex>

char *read() {
  for (std::string line; std::getline(std::cin, line);) {
        // Get content-length from stdin
        int length = 0;
        const std::regex regex("Content-Length: ([0-9]+)");
        std::smatch match;
        if (std::regex_match(line, match, regex)) {
            // First match is whole string, second match is the capture group
            // std::cout << "match: " << match[1] << std::endl;
            length = std::stoi(match[1]);
        }
        // Read `length` chars from stdin
        std::string str(length, '\0');
        std::cin.read(&str[0], length);
        if (!std::cin) {
            std::cout << "Error reading from stdin" << std::endl;
        }
        // std::cout << "str: " << str << std::endl;

        // Mr. OS please clean this up, ty.
        char *result = new char[str.length() + 1];
        strcpy(result, str.c_str());
        return result;
    }
    std::cout << "Error reading from stdin" << std::endl;
    return nullptr;
}

int main() {
  read();
}
