#include "log.h"

int main(int argc, char* argv[]){

    init_log_file("./file", APPEND);

    log_error("test");

    log_setColor(7, RED_BACK);

    log_error("test");
    return 0;
}