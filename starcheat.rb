class Starcheat < Formula
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

  option "without-app", "Build without the .app (started via starcheat terminal command)"

  depends_on "python"
  depends_on "pyqt"
  depends_on "jpeg"

  def install
    ENV["PYTHONPATH"] = lib/"python#{/\d\.\d/.match `python3 --version 2>&1`}/site-packages"
    system "pip3", "install", "Pillow", "--upgrade"
    system "python3", "build.py", "-v"
    libexec.install Dir["build/*"]
    bin.install_symlink libexec+"starcheat.py" => "starcheat"

    if build.with? "app"
      mkdir_p prefix/"StarCheat.app/Contents/MacOS"
      mkdir_p prefix/"StarCheat.app/Contents/Resources"
      cp "mac/icon.icns", prefix/"StarCheat.app/Contents/Resources"
      (prefix/"StarCheat.app/Contents/MacOS/starcheat").write <<-EOS.undent
        #!
        #{Formula["python"].opt_bin}/python3 #{opt_bin}/starcheat $1
      EOS
      chmod 0755, prefix/"StarCheat.app/Contents/MacOS/starcheat"
      (prefix/"StarCheat.app/Contents/Info.plist").write <<-EOS.undent
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
  end

  def caveats
    <<-EOS.undent
      You can run this to symlink the StarCheat.app into your Application folder:
        `brew linkapps starcheat`
      or just run if from:
        #{prefix}/StarCheat.app
    EOS
  end if build.with? "app"

  test do
    ENV["HOME"] = nil
    system bin/"starcheat", "-v"
    system prefix/"StarCheat.app/Contents/MacOS/starcheat", "-v" if build.with? "app"
  end
end
