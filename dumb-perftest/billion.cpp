#include <cstdint>
#include <cstdio>

int main(void) {
  std::uint32_t n = 0;

  while (n < 1000000000)
    n++;
  std::printf("%i", n);
}