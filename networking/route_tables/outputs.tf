output "route_table_private_id" {
  value       = aws_route_table.private.id
  description = "Private Route Table ID"
}

output "route_table_public_id" {
  value       = aws_route_table.public.id
  description = "Public Route Table ID"
}