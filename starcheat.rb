class Starcheat < Formula
  include Language::Python::Virtualenv
  desc "Starbound player save file editor"
  homepage "https://github.com/wizzomafizzo/starcheat"
  url "https://github.com/wizzomafizzo/starcheat.git",
      :tag => "0.27.1",
      :revision => "17dd471bc223d5c8a1a74f1e4a2eee035246ce36"
  head "https://github.com/wizzomafizzo/starcheat.git", :branch => "dev"

  devel do
    url "https://github.com/medeor413/starcheat.git"
    version "1.0"
  end

  depends_on "python"
  depends_on "pyqt"
  depends_on "jpeg"

  resource "Pillow" do
    url "https://files.pythonhosted.org/packages/0f/57/25be1a4c2d487942c3ed360f6eee7f41c5b9196a09ca71c54d1a33c968d9/Pillow-5.0.0.tar.gz"
    sha256 "12f29d6c23424f704c66b5b68c02fe0b571504459605cfe36ab8158359b0e1bb"
  end

  def install
    venv = virtualenv_create(libexec)
    venv.pip_install resources
    system "python3", "build.py", "-v"
    libexec.install Dir["build/*"]
    bin.install_symlink libexec/"starcheat.py" => "starcheat"

    mkdir_p libexec/"StarCheat.app/Contents/MacOS"
    mkdir_p libexec/"StarCheat.app/Contents/Resources"
    cp "mac/icon.icns", libexec/"StarCheat.app/Contents/Resources"
    (libexec/"StarCheat.app/Contents/MacOS/starcheat").write <<~EOS
      #!
      #{Formula["python"].opt_bin}/python3 #{opt_bin}/starcheat $1
    EOS
    chmod 0755, libexec/"StarCheat.app/Contents/MacOS/starcheat"
    (libexec/"StarCheat.app/Contents/Info.plist").write <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
            <key>CFBundleDevelopmentRegion</key>
            <string>English</string>
            <key>CFBundleExecutable</key>
            <string>starcheat</string>
            <key>CFBundleIconFile</key>
            <string>icon.icns</string>
            <key>CFBundleIdentifier</key>
            <string>org.starcheat</string>
            <key>CFBundleInfoDictionaryVersion</key>
            <string>6.0</string>
            <key>CFBundleName</key>
            <string>StarCheat</string>
            <key>CFBundlePackageType</key>
            <string>APPL</string>
            <key>CFBundleShortVersionString</key>
            <string>0.1</string>
            <key>CFBundleSignature</key>
            <string>????</string>
            <key>CFBundleVersion</key>
            <string>0.1</string>
            <key>NSAppleScriptEnabled</key>
            <false/>
            <key>NSMainNibFile</key>
            <string>MainMenu</string>
            <key>NSPrincipalClass</key>
            <string>NSApplication</string>
        </dict>
      </plist>
    EOS
  end

  def caveats
    <<~EOS
      You can run this to symlink the StarCheat.app into your Application folder:
        `brew linkapps starcheat`
      or just run if from:
        open #{libexec}/StarCheat.app
    EOS
  end

  test do
    ENV["HOME"] = nil
    system bin/"starcheat", "-v"
    system libexec/"StarCheat.app/Contents/MacOS/starcheat", "-v"
  end
end
