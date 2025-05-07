# ===========
# Define IAM Role
# ===========

resource "aws_iam_role" "lambda_exec_role" {
  name = "users-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "dynamodb_fullaccess_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

# To access S3 resource
resource "aws_iam_role_policy_attachment" "S3_fullaccess_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# resource "aws_iam_role_policy" "lambda_exec_policy" {
#   name = "lambda-execution-policy"
#   role = aws_iam_role.lambda_exec_role.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy" "dynamodb_fullaccess_policy" {
#   name = "dynamodb_fullaccess_policy"
#   role = aws_iam_role.lambda_exec_role.id

#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": [
#                 "dynamodb:*",
#                 "dax:*",
#                 "application-autoscaling:DeleteScalingPolicy",
#                 "application-autoscaling:DeregisterScalableTarget",
#                 "application-autoscaling:DescribeScalableTargets",
#                 "application-autoscaling:DescribeScalingActivities",
#                 "application-autoscaling:DescribeScalingPolicies",
#                 "application-autoscaling:PutScalingPolicy",
#                 "application-autoscaling:RegisterScalableTarget",
#                 "cloudwatch:DeleteAlarms",
#                 "cloudwatch:DescribeAlarmHistory",
#                 "cloudwatch:DescribeAlarms",
#                 "cloudwatch:DescribeAlarmsForMetric",
#                 "cloudwatch:GetMetricStatistics",
#                 "cloudwatch:ListMetrics",
#                 "cloudwatch:PutMetricAlarm",
#                 "cloudwatch:GetMetricData",
#                 "datapipeline:ActivatePipeline",
#                 "datapipeline:CreatePipeline",
#                 "datapipeline:DeletePipeline",
#                 "datapipeline:DescribeObjects",
#                 "datapipeline:DescribePipelines",
#                 "datapipeline:GetPipelineDefinition",
#                 "datapipeline:ListPipelines",
#                 "datapipeline:PutPipelineDefinition",
#                 "datapipeline:QueryObjects",
#                 "ec2:DescribeVpcs",
#                 "ec2:DescribeSubnets",
#                 "ec2:DescribeSecurityGroups",
#                 "iam:GetRole",
#                 "iam:ListRoles",
#                 "kms:DescribeKey",
#                 "kms:ListAliases",
#                 "sns:CreateTopic",
#                 "sns:DeleteTopic",
#                 "sns:ListSubscriptions",
#                 "sns:ListSubscriptionsByTopic",
#                 "sns:ListTopics",
#                 "sns:Subscribe",
#                 "sns:Unsubscribe",
#                 "sns:SetTopicAttributes",
#                 "lambda:CreateFunction",
#                 "lambda:ListFunctions",
#                 "lambda:ListEventSourceMappings",
#                 "lambda:CreateEventSourceMapping",
#                 "lambda:DeleteEventSourceMapping",
#                 "lambda:GetFunctionConfiguration",
#                 "lambda:DeleteFunction",
#                 "resource-groups:ListGroups",
#                 "resource-groups:ListGroupResources",
#                 "resource-groups:GetGroup",
#                 "resource-groups:GetGroupQuery",
#                 "resource-groups:DeleteGroup",
#                 "resource-groups:CreateGroup",
#                 "tag:GetResources",
#                 "kinesis:ListStreams",
#                 "kinesis:DescribeStream",
#                 "kinesis:DescribeStreamSummary"
#             ],
#             "Effect": "Allow",
#             "Resource": "*"
#         },
#         {
#             "Action": "cloudwatch:GetInsightRuleReport",
#             "Effect": "Allow",
#             "Resource": "arn:aws:cloudwatch:*:*:insight-rule/DynamoDBContributorInsights*"
#         },
#         {
#             "Action": [
#                 "iam:PassRole"
#             ],
#             "Effect": "Allow",
#             "Resource": "*",
#             "Condition": {
#                 "StringLike": {
#                     "iam:PassedToService": [
#                         "application-autoscaling.amazonaws.com",
#                         "application-autoscaling.amazonaws.com.cn",
#                         "dax.amazonaws.com"
#                     ]
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "iam:CreateServiceLinkedRole"
#             ],
#             "Resource": "*",
#             "Condition": {
#                 "StringEquals": {
#                     "iam:AWSServiceName": [
#                         "replication.dynamodb.amazonaws.com",
#                         "dax.amazonaws.com",
#                         "dynamodb.application-autoscaling.amazonaws.com",
#                         "contributorinsights.dynamodb.amazonaws.com",
#                         "kinesisreplication.dynamodb.amazonaws.com"
#                     ]
#                 }
#             }
#         }
#     ]
# })
# }