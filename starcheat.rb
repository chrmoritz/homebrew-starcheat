class Starcheat < Formula
  include Language::Python::Virtualenv
  desc "Starbound player save file editor"
  homepage "https://github.com/wizzomafizzo/starcheat"
  url "https://github.com/medeor413/starcheat.git",
      :revision => "4994d3f8d9a254c8a762983424066915b326450c"
  version "1.0"
  head "https://github.com/wizzomafizzo/starcheat.git", :branch => "dev"

  depends_on "freetype"
  depends_on "jpeg"
  depends_on "pyqt"
  depends_on "python"

  def install
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
      NOTICE: Please install the required Pillow (image library) depednecy yourself:
        `pip3 install --upgrade Pillow`

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
