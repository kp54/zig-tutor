const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    var count: u8 = 1;

    while (count <= 100) : (count += 1) {
        const fizz: u2 = @intFromBool(count % 3 == 0);
        const buzz: u2 = @intFromBool(count % 5 == 0);

        switch ((buzz << 1) + fizz) {
            0b11 => try stdout.print("FizzBuzz\n", .{}),
            0b10 => try stdout.print("Buzz\n", .{}),
            0b01 => try stdout.print("Fizz\n", .{}),
            0b00 => try stdout.print("{d}\n", .{count}),
        }
    }
}
