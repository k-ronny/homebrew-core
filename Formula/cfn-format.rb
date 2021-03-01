class CfnFormat < Formula
  desc "Command-line tool for formatting AWS CloudFormation templates"
  homepage "https://github.com/aws-cloudformation/rain"
  url "https://github.com/aws-cloudformation/rain/archive/v1.1.2.tar.gz"
  sha256 "c5004a0d63e09949d2d89f7368dda12e9bf137cc6804b3eaa35a5b1f55320010"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "78cf14405e2bc20b7914cb2e357b5f806fd8a89bdb65792e5d2049a87dce32e3"
    sha256 cellar: :any_skip_relocation, big_sur:       "736d8ccf911a2de6edeff90bed1ffe207ea9e1c21c0fd09c1afb724400152703"
    sha256 cellar: :any_skip_relocation, catalina:      "3ffc8a003adc05637ed75636c41249452feb297d72b40227699681529b8b66ed"
    sha256 cellar: :any_skip_relocation, mojave:        "d68a3331c643ee79c0b815dbe655ef5773e0a9e5e2c6b9f4f8fb2d7112bfeafb"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "cmd/cfn-format/main.go"
  end

  test do
    (testpath/"test.template").write <<~EOS
      Resources:
        Bucket:
          Type: AWS::S3::Bucket
    EOS
    assert_equal "test.template: formatted OK", shell_output("#{bin}/cfn-format -v test.template").strip
  end
end
