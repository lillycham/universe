CC :=clang
CCVERSION :=$(shell $(CC) -dumpversion)
CFLAGS :=-Wshadow -Wall -Wextra -Wpedantic -Wstrict-overflow -Wfatal-errors -Wno-unused-function -fno-strict-aliasing -Wno-nullability-completeness -Wno-nullability-extension -std=c11
BUILD_DIR := build
SRCS := main.c stack.c

all: cnotes

cnotes: |$(BUILD_DIR)
	@echo -n 'building stackm with: '
	@$(CC) --version | sed 1q
	$(CC) -o $(BUILD_DIR)/stackm $(SRCS) $(CFLAGS)

$(BUILD_DIR):
	@echo "Folder $(BUILD_DIR) does not exist, creating it..."
	mkdir -p $@

