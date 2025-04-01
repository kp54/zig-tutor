const std = @import("std");
const expect = std.testing.expect;

const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{
    OutOfMemory,
};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

test "error union" {
    const maybe_error: AllocationError!u16 = AllocationError.OutOfMemory;
    const no_error = maybe_error catch @as(u16, 42);

    try expect(@TypeOf(maybe_error) == AllocationError!u16);
    try expect(maybe_error == AllocationError.OutOfMemory);

    try expect(@TypeOf(no_error) == u16);
    try expect(no_error == 42);
}

fn failingFunction() error{Oops}!void {
    return error.Oops;
}

test "returning an error" {
    failingFunction() catch |err| {
        try expect(err == error.Oops);
        return;
    };

    expect(6 * 7 == 42) catch |err| return err;
}

var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expect(err == error.Oops);
        try expect(problems == 99);
        return;
    };
}

fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    const x: error{AccessDenied}!void = createFile();

    _ = x catch {};
}

const A = error{
    NotDir,
    PathNotFound,
};
const B = error{
    OutOfMemory,
    PathNotFound,
};

const C = A || B;
