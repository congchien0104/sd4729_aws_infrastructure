
// Create ECR reposiroty
resource "aws_ecr_repository" "devops-be-ecr" {
  name = "todo-be"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "devops-fe-ecr" {
  name = "todo-fe"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}