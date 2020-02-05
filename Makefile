DIR_BUILD=build
DIR_SRC=src

TARGET=$(DIR_BUILD)/tailos.elf

CC=sdcc
LDFLAGS=-mstm8 --out-fmt-elf
CFLAGS=-mstm8 --out-fmt-elf
INCLUDES=

SRC_MAIN=$(DIR_SRC)/main.c
OBJ_MAIN=$(DIR_BUILD)/$(DIR_SRC)/main.rel
SRCS=$(filter-out $(SRC_MAIN),$(wildcard $(DIR_SRC)/*.c))
OBJS=$(addprefix $(DIR_BUILD)/,$(addsuffix .rel,$(basename $(SRCS))))

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJ_MAIN) $(OBJS)
	@mkdir -p $(dir $@)
	@echo "link and compile binary"
	$(CC) $(LDFLAGS) $(INCLUDES) -o $(TARGET) $(OBJ_MAIN) $(OBJS)

$(DIR_BUILD)/$(DIR_SRC)/%.rel: $(DIR_SRC)/%.c
	@mkdir -p $(dir $@)
	@echo "compile $<"
	$(CC) $(CFLAGS) $(INCLUDES) -o $(dir $@) -c $<


clean:
	@echo "remove build directory"
	@rm -rf $(DIR_BUILD)
