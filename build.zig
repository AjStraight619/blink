const std = @import("std");
const build_capy = @import("capy");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "blink",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const capy_dep = b.dependency("capy", .{
        .target = target,
        .optimize = optimize,
        .app_name = @as([]const u8, "Blink"),
    });
    const capy = capy_dep.module("capy");
    exe.root_module.addImport("capy", capy);

    b.installArtifact(exe);

    const run_cmd = try build_capy.runStep(exe, .{ .args = b.args });
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(run_cmd);

    const exe_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe_unit_tests.root_module.addImport("capy", capy);

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}
