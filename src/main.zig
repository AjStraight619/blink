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

    // Initialize window (sets up but doesn't show yet)
    var window = try Window.init(allocator);

    // Actually display the window (and apply state)
    window.show();

    // Later you can replace the content:
    // try window.setContent(YourEditorWidget.create());

    capy.runEventLoop();
}
