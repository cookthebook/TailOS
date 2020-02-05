DIR_BUILD=build
DIR_SRC=src

TARGET=$(DIR_BUILD)/tailos.elf

CC=sdcc
LDFLAGS=-mstm8 --out-fmt-elf
CFLAGS=-mstm8 --out-fmt-elf
INCLUDES=

SRCS=$(wildcard $(DIR_SRC)/*.c)
OBJS=$(addprefix $(DIR_BUILD)/,$(addsuffix .rel,$(basename $(SRCS))))

.PHONY: all clean

all: $(TARGET)

# TODO: main must be first
$(TARGET): $(OBJS)
	@mkdir -p $(dir $@)
	@echo "link and compile binary"
	$(CC) $(LDFLAGS) $(INCLUDES) -o $(TARGET) $(OBJS)

$(DIR_BUILD)/$(DIR_SRC)/%.rel: $(DIR_SRC)/%.c
	@mkdir -p $(dir $@)
	@echo "compile $<"
	$(CC) $(CFLAGS) $(INCLUDES) -o $(dir $@) $<


clean:
	@echo "remove build directory"
	@rm -rf $(DIR_BUILD)