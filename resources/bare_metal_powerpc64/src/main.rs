#![no_std]
#![no_main]

use core::panic::PanicInfo;

// Define the entry point of the program
#[no_mangle]
pub extern "C" fn _start() -> ! {
    // Typically, you would initialize hardware and set up your runtime here

    // Infinite loop to prevent exit
    loop {}
}

// This function is called on panic, required when no_std is used
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
