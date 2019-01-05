NAME=libasm.a

SRC=$(wildcard src/*.s)
OBJ=$(patsubst src/%.s, obj/%.o, $(SRC))
CC=clang
CFLAGS=-Wall -Wextra -Werror -g
LDFLAGS=-Isrc -L. -lasm

all: $(NAME)

$(NAME): $(OBJ)
	@ar rcs $(NAME) $(OBJ)

obj/%.o: src/%.s
	@mkdir -p obj
	@nasm -f elf64 -o $@ $<

test: $(NAME) force
	@$(CC) $(CFLAGS) test/test.c -o test/test $(LDFLAGS)
	@./test/test

clean:
	@rm -rf obj
	@rm -f test/test

fclean: clean
	@rm -f $(NAME)

re: fclean all

force:
