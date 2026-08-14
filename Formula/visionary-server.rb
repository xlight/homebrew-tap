class VisionaryServer < Formula
  desc "DeepSeek Visionary MCP server (native binary): vision pipeline + auto-login + stdio MCP service"
  homepage "https://github.com/xlight/deepseek-visionary"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xlight/deepseek-visionary/releases/download/v0.5.0/visionary-server-aarch64-apple-darwin.tar.xz"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xlight/deepseek-visionary/releases/download/v0.5.0/visionary-server-x86_64-apple-darwin.tar.xz"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xlight/deepseek-visionary/releases/download/v0.5.0/visionary-server-aarch64-unknown-linux-gnu.tar.xz"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xlight/deepseek-visionary/releases/download/v0.5.0/visionary-server-x86_64-unknown-linux-gnu.tar.xz"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "visionary-server"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "visionary-server"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "visionary-server"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "visionary-server"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
