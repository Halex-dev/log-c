# Compilation options
CC 		= gcc
CFLAGS 	+= -std=c99 -Wall -pedantic -g -I./src/ -D_POSIX_C_SOURCE=200112L -D_DEFAULT_SOURCE -DLOG_USE_COLOR

# Directories

# ------------------- SYSTEM ------------------- #
SCRIPT_DIR  	= ./scripts
CODE_DIR		= ./src
EXAMPLE_DIR		= ./src/example
LOG_DIR 		= ./file
# ------------------- OTHER ------------------- #
OBJ_DIR			= ./objs
LIB_DIR			= ./libs
EXEC_DIR		= ./execute

# Dynamic linking
DYN_LINK = -L$(LIB_DIR) -Wl,-rpath,$(LIB_DIR)

# 	---------------- Default rule ----------------	#

all : createDir $(EXEC_DIR)

#	--------------- Execute scripts --------------	#

.PHONY: createDir 
createDir:
	@bash $(SCRIPT_DIR)/createDir.sh

#	-------------- Logs Library -------------  #

UTIL_SRC := $(wildcard $(CODE_DIR)/*.c)
UTIL_OBJ := $(patsubst $(CODE_DIR)/%.c, $(OBJ_DIR)/log/%.o, $(UTIL_SRC))
UTIL_INC := $(patsubst $(CODE_DIR)/%.c, $(CODE_DIR)/%.h, $(UTIL_SRC))

$(LIB_DIR)/liblog.so : $(UTIL_OBJ)
	$(CC) $(CFLAGS) -shared $^ -o $@

$(OBJ_DIR)/log/%.o : $(CODE_DIR)/%.c $(OBJ_DIR)/log/%.h  $(OBJ_DIR)/log/log.o
	$(CC) $(CFLAGS) $< -c -fPIC -o $@

$(OBJ_DIR)/log/log.o : $(CODE_DIR)/log.c $(CODE_DIR)/log.h
	$(CC) $(CFLAGS) $< -c -fPIC -o $@

# 	------------------- Server ------------------- 	#

EXAMPLE_SRC := $(wildcard $(EXAMPLE_DIR)/*.c)
EXAMPLE_OBJ := $(patsubst $(EXAMPLE_DIR)/%.c, $(OBJ_DIR)/example/%.o, $(EXAMPLE_SRC))

EXAMPLE_DEPS := $(LIB_DIR)/liblog.so
EXAMPLE_LIBS := $(DYN_LINK) -lpthread -llog

$(EXEC_DIR) : $(EXAMPLE_OBJ)
	$(CC) $(CFLAGS) $^ -o $@/ex1 $(EXAMPLE_LIBS)

$(OBJ_DIR)/example/%.o : $(CODE_DIR)/example/%.c $(EXAMPLE_DEPS)
	$(CC) $(CFLAGS) $< -c -o $@


# 	------------------ Cleaning ------------------	#
.PHONY: clean
clean: 
	@echo "Removing make files..."
	@rm -f vgcore.* 
	@rm -rf $(OBJ_DIR)/*
	@rm -rf $(EXEC_DIR)/*
	@rm -rf $(LIB_DIR)/*
	@rm -rf $(LOG_DIR)/*
	@echo "Cleaning complete!"