const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const raw_args = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, raw_args);
    const args = raw_args[1..];

    if (args.len == 0) {
        return error.ExpectedArgument;
    }

    for (args) |arg| {
        const f = try std.fmt.parseFloat(f32, arg);
        const c = (f - 32) * (5.0 / 9.0);
        try stdout.print("{d:.1}c\n", .{c});
    }
}
