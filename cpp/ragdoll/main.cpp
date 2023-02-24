//
//  main.cpp
//  ragdoll
//
//  Created by Lilly Cham on 20/02/2023.
//

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

const std::string prog_name = "ragdoll";

void err_exit(std::string message, int code = EXIT_FAILURE) {
  std::cerr << prog_name << ": " << message;
  exit(code);
  
}

void cat(std::istream & in) {
  std::cout << in.rdbuf();
}

int main(int argc, const char * argv[]) {
  std::ios_base::sync_with_stdio(false);
  
  std::vector<std::string> argvec(argv + 1, argv + argc);
  
  if (argc < 2) {
    cat(std::cin);
    exit(EXIT_SUCCESS);
  }
  
  for (std::string name : argvec) {
    std::ifstream file;
    try {
      file.open(name);
      if (!std::filesystem::exists(name)) {
        err_exit("no such file or directory: " + name);
      }
      if (std::filesystem::is_directory(name)) {
        err_exit("is a directory: " + name);
      }
      cat(file);
    } catch (std::system_error & e) {
      err_exit("Failed to acquire handle to file " + name + " " + e.what());
    }
  }
  return 0;
}
