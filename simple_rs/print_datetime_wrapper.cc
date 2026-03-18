#include <cstdlib>
#include <iostream>
#include <chrono>
#include <ctime>
#include <iomanip>

//
// C++ function to be called from print_time.rs
//

extern "C" void print_current_datetime() {
    using namespace std;
    using namespace std::chrono;

    // get current time
    auto now = system_clock::now();
    time_t now_c = system_clock::to_time_t(now);

    // convert to local time
    tm local_tm{};
#if defined(_WIN32)
    localtime_s(&local_tm, &now_c);
#else
    localtime_r(&now_c, &local_tm);
#endif

    cout << "C++ current date/time: "
         << put_time(&local_tm, "%Y-%m-%d %H:%M:%S")
         << endl;
}

//
// main calling rust_entry from print_time.rs
// 

extern "C" void rust_entry();
int main() {
    rust_entry();
    return EXIT_SUCCESS;
}

