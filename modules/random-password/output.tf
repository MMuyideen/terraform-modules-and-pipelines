output "password" {
  value     = random_password.vm_password.result
  sensitive = true
}