
# Create ECR
resource "aws_ecr_repository" "devops" {
  name = "devops"
}

# Create EC2 ECR role