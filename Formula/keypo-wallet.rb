class KeypoWallet < Formula
  desc "ERC-4337 smart wallet CLI with Secure Enclave P-256 signing"
  homepage "https://github.com/keypo-us/keypo-wallet"
  version "0.4.0"
  license "MIT"

  url "https://github.com/keypo-us/keypo-wallet/releases/download/v#{version}/keypo-wallet-#{version}-macos-arm64.tar.gz"
  sha256 "116719f53e744a591e6e4ff108c221632690fb8b2234b1134e3686788fc0c58a"

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
