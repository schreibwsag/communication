#[link(name = "stdc++")]   // often unnecessary because g++ is the linker, but harmless
extern "C" {
    fn print_current_datetime();
}

#[no_mangle]
pub extern "C" fn rust_entry() {
    println!("Hello from Rust!");

    unsafe {
        print_current_datetime();
    }
}

