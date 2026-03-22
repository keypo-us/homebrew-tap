class KeypoWallet < Formula
  desc "ERC-4337 smart wallet CLI with Secure Enclave P-256 signing"
  homepage "https://github.com/keypo-us/keypo-wallet"
  version "0.4.2"
  license "MIT"

  url "https://github.com/keypo-us/keypo-wallet/releases/download/v#{version}/keypo-wallet-#{version}-macos-arm64.tar.gz"
  sha256 "3d063acfe5423e0f478322589cbc45ee49acea8cafab8e8466799c2535a24081"

  depends_on macos: :sonoma
  depends_on arch: :arm64

  def install
    bin.install "keypo-wallet"
    bin.install "keypo-signer"
  end

  def caveats
    <<~EOS
      keypo-wallet requires Apple Silicon (M1 or later).
      macOS 14 (Sonoma) or later is required.

      Touch ID signing requires Touch ID hardware:
        - MacBook Pro/Air with Touch ID
        - Mac with Magic Keyboard with Touch ID

      Signing keys are stored in the Secure Enclave and cannot be extracted.

      On first launch, macOS contacts Apple's servers to verify
      the notarization ticket (internet connection required).
    EOS
  end

  conflicts_with "keypo-signer", because: "keypo-wallet includes keypo-signer"

  test do
    system "#{bin}/keypo-wallet", "--help"
    assert_match version.to_s, shell_output("#{bin}/keypo-signer info --system")
  end
end
