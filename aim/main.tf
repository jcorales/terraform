provider "aws" {
    region = var.aws_region[0]
  
}

resource "aws_iam_user" "user1" {
    name = var.user1

}

resource "aws_iam_policy" "policy_terraform_1" {
    name = var.policyname1
    policy = <<EOT
{

  "Version": "2012-10-17",

  "Statement": [

    {

      "Action": [

        "s3:ListAllMyBuckets"

      ],

      "Effect": "Allow",

      "Resource": "*"

    }

  ]

}
EOT 


}

resource "aws_iam_user_policy_attachment" "attach_policy_terraform" {
  user       = aws_iam_user.user1.name
  policy_arn = aws_iam_policy.policy_terraform_1.arn
}