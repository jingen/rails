class IssueMailer < ActionMailer::Base
  default from: "rails@issues.com"

  def issue_created(issue)
  	@issue = issue
  	mail subject: "A new issue was created", to: "linjingen@hotmail.com"
  end
end
