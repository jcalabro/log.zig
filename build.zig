const std = @import("std");

pub fn build(b: *std.Build) !void {
	const target = b.standardTargetOptions(.{});
	const optimize = b.standardOptimizeOption(.{});

	_ = b.addModule("logz", .{
		.root_source_file = .{ .path = "src/logz.zig" },
	});

	const lib_test = b.addTest(.{
		.root_source_file = .{ .path = "src/logz.zig" },
		.target = target,
		.optimize = optimize,
		.test_runner = "test_runner.zig",
	});
	const run_test = b.addRunArtifact(lib_test);
	run_test.has_side_effects = true;

	const test_step = b.step("test", "Run tests");
	test_step.dependOn(&run_test.step);
}
