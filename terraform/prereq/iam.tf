################################################################################
# IAM Role - Github Access
################################################################################
data "aws_iam_policy_document" "oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    condition {
      test     = "StringLike"
      values   = ["repo:YourOrg/*"]
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}

resource "aws_iam_role" "github_role" {
  name               = "${var.project_name}_github_oidc_role"
  assume_role_policy = data.aws_iam_policy_document.oidc_assume_role_policy.json
}

data "aws_iam_policy_document" "deployment_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:*",
      "eks:*",
      "ec2:*",
      "iam:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "deploy_policy" {
  name        = "${var.project_name}_cicd-deploy-policy"
  description = "Policy used for deployments on CICD"
  policy      = data.aws_iam_policy_document.deployment_policy_document.json
}

resource "aws_iam_role_policy_attachment" "attach-deploy" {
  role       = aws_iam_role.github_role.name
  policy_arn = aws_iam_policy.deploy_policy.arn
}
