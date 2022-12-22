$(shell clang-format -i src/*.cpp)
CC = g++

EXEC ?= run.out
SRC_DIRS ?= ./src

SRCS := $(shell find $(SRC_DIRS) -name *.cpp)
OBJECTS := $(addsuffix .o,$(basename $(SRCS)))
DEPS := $(OBJECTS:.o=.d)

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CPPFLAGS = $(CUSTOM) $(INC_FLAGS) -MMD -MP -g -fPIC -Wall -Wextra -Werror -std=c++17
LDFLAGS = -shared

$(EXEC): $(OBJECTS)
	$(CC) $(CPPFLAGS) $(OBJECTS) -o $@
	$(CC) $(LDFLAGS) -o external.so $(OBJECTS)

.PHONY: clean
clean:
	$(RM) $(EXEC) $(OBJECTS) $(DEPS)

-include $(DEPS)
