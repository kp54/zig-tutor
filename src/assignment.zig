fn assignment() void {
    const constant: i32 = 5;
    _ = constant;
    var variable: u32 = 5000;

    const inferred_constant = @as(i32, 5);
    _ = inferred_constant;
    var inferred_variable = @as(u32, 5000);

    inferred_variable = variable ^ inferred_variable;
    variable = inferred_variable ^ variable;
    inferred_variable = variable ^ inferred_variable;
}
