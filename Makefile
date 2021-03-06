CC = g++
CFLAGS = -c -std=c++11 $(shell pkg-config --cflags playerc++)
LDFLAGS = $(shell pkg-config --libs playerc++)

SRC = source/
BIN = build/

PROG = args RobotCommunication SocketConnection RobotBehavior
TARGET = swarm

BINS = $(addsuffix .o, $(addprefix $(BIN), $(basename $(PROG))))

all: $(BIN) $(BIN)$(TARGET) test

$(BIN)$(TARGET): $(BINS) $(BIN)$(TARGET).o
	$(CC) $(BINS) $(BIN)$(TARGET).o -o $(BIN)$(TARGET) $(LDFLAGS)

$(BIN)%.o: $(SRC)%.cpp
	$(CC) $(CFLAGS) $< -o $@

$(BIN):
	mkdir -p $(BIN)

# build test codes
test: $(BIN) $(BINS) testCmd randPos

randPos: $(BINS) $(BIN)randPos.o
	$(CC) $(BINS) $(BIN)randPos.o -o $(BIN)randPos $(LDFLAGS)

testCmd: $(BINS) $(BIN)testCmd.o
	$(CC) $(BINS) $(BIN)testCmd.o -o $(BIN)testCmd $(LDFLAGS)

clean:
	rm -f $(BIN)*