const std = @import("std");
const capy = @import("capy");
const Allocator = std.mem.Allocator;

const Window = @This();

pub const State = enum {
    normal,
    fullscreen,
};

pub const Config = struct {
    title: [:0]const u8 = "Blink",
    state: State = .normal,
    normal_width: u32 = 1200,
    normal_height: u32 = 800,
};

window: capy.Window,
config: Config,
alloc: Allocator,

pub fn init(alloc: Allocator) !Window {
    const cfg = loadConfigOrDefault(alloc);
    var window = try capy.Window.init();

    window.setTitle(cfg.title);
    window.setPreferredSize(cfg.normal_width, cfg.normal_height);

    try window.set(capy.column(.{}, .{
        capy.label(.{ .text = "Lets go, lets go" }),
    }));

    return Window{
        .window = window,
        .config = cfg,
        .alloc = alloc,
    };
}

pub fn show(self: *Window) void {
    // ? Window.setFullScreen() bugged?
    self.window.show();
}

fn loadConfigOrDefault(alloc: Allocator) Config {
    _ = alloc;
    return .{}; // Uses field defaults
}
