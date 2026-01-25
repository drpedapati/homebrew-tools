class MacControl < Formula
  desc "macOS GUI automation using Accessibility API and pyautogui"
  homepage "https://github.com/henrybloomingdale/mac-control"
  head "https://github.com/henrybloomingdale/mac-control.git", branch: "main"
  license "MIT"
  version "0.1.0"

  depends_on "python@3.12"

  def install
    # Create a virtualenv
    venv = virtualenv_create(libexec, "python3.12")
    
    # Install dependencies
    system libexec/"bin/pip", "install", 
           "pyautogui>=0.9.54",
           "pillow>=10.0.0",
           "pyobjc-framework-Quartz>=10.0",
           "pyax>=0.3.0"
    
    # Install the package itself
    system libexec/"bin/pip", "install", "--no-deps", buildpath
    
    # Link the executables
    bin.install_symlink libexec/"bin/mac-control"
    bin.install_symlink libexec/"bin/mac-ui"
  end

  def caveats
    <<~EOS
      mac-control requires Accessibility permissions to control the mouse/keyboard.
      
      Enable in: System Settings → Privacy & Security → Accessibility
      
      Quick start:
        mac-ui list "Finder"        # List clickable elements  
        mac-ui click 5              # Click element by index
        mac-ui click 100 200        # Click at coordinates
        mac-control screenshot      # Take screenshot
        mac-control key "cmd+c"     # Press key combo
    EOS
  end

  test do
    assert_match "position", shell_output("#{bin}/mac-control position")
  end
end
