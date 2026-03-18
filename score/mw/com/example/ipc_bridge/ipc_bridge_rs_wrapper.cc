#include <cstdlib>

//
// main calling main_entry from ipc_bridge.rs
// 

extern "C" void main_entry();
int main() {
    main_entry();
    return EXIT_SUCCESS;
}

