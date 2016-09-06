require "jobs/eslint_review_job"

RSpec.describe EslintReviewJob do
  include LintersHelper

  context "when file with .js extention contains violations" do
    it "reports violations" do
      expect_violations_in_file(
        content: content,
        filename: "foo/test.js",
        violations: [
          {
            line: 2,
            message: "Unexpected console statement  no-console",
          },
        ],
      )
    end
  end

  context "when custom configuraton is provided" do
    it "respects the custom configuration" do
      config = <<~JSON
        {
          "rules": {
            "no-console": "off"
          }
        }
      JSON

      expect_violations_in_file(
        config: config,
        content: content,
        filename: "foo/test.js",
        violations: [],
      )
    end
  end

  context "when file with .jsx extention contains violations" do
    it "reports violations" do
      expect_violations_in_file(
        content: content,
        filename: "foo/test.jsx",
        violations: [
          {
            line: 2,
            message: "Unexpected console statement  no-console",
          },
        ],
      )
    end
  end

  def content
    <<~JS
      'use strict';
      console.log('hello');
    JS
  end
end
