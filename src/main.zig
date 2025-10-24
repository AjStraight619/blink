const std = @import("std");
const capy = @import("capy");
const Window = @import("ui/window.zig");
pub usingnamespace capy.cross_platform;

const File = std.fs.File;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    try capy.init();
    defer capy.deinit();

    var window = try Window.init(allocator);

    window.show();

    capy.runEventLoop();
}
