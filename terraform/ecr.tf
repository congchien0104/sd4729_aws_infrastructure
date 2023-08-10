
// Create ECR reposiroty
resource "aws_ecr_repository" "devops-be-ecr" {
  name = "backend"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "devops-fe-ecr" {
  name = "frontend"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}