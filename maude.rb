class Maude < Formula
  desc "High-performance reflective language and system"
  homepage "https://github.com/maude-lang/Maude"
  version "3.5"
  url "https://github.com/maude-lang/Maude/releases/download/Maude3.5/Maude-3.5-macos-arm64.zip"
  sha256 "c656ff4495a35fc544c7905eae80d9179a4b806ecbe3f948a7305f6e31e250d0"

  def install
    bin.install "maude" => "maude.orig"
    
    libexec.install "file.maude"
    libexec.install "linear.maude"
    libexec.install "machine-int.maude"
    libexec.install "metaInterpreter.maude"
    libexec.install "model-checker.maude"
    libexec.install "prelude.maude"
    libexec.install "prng.maude"
    libexec.install "process.maude"
    libexec.install "smt.maude"
    libexec.install "socket.maude"
    libexec.install "term-order.maude"
    libexec.install "time.maude"
    
    libexec.install "maude.sty"
    
    # ラッパースクリプトを作成
    (bin/"maude").write <<~EOS
      #!/bin/bash
      export MAUDE_LIB="#{libexec}"
      exec "#{bin}/maude.orig" "$@"
    EOS
  end
  
  def caveats
    <<~EOS
      Maude has been installed with library files in:
        #{libexec}

      The MAUDE_LIB environment variable is automatically set when running maude.
    EOS
  end
  
  test do
    (testpath/"test.maude").write <<~EOS
      fmod TEST is
        sort Nat .
        op zero : -> Nat .
        op s : Nat -> Nat .
      endfm
      quit .
    EOS
    
    assert_match "Bye", shell_output("#{bin}/maude test.maude")
  end
end
