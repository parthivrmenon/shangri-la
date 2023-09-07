output "eks_iam_role_arn" {
  description = "IAM role for EKS"
  value       = aws_iam_role.eks-iam-role.arn

}

output "eks_worker_iam_role_arn" {
  description = "IAM role for EKS worker"
  value       = aws_iam_role.eks-worker-iam-role.arn

}