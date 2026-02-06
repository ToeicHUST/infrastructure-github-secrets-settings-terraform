# variables.tf

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

variable "secrets" {
  description = "Map các secret cần tạo (Key = Tên, Value = Giá trị)"
  type        = map(string)
  # sensitive   = true
}

# # --- THÊM MỚI ---
# variable "repositories" {
#   description = "Danh sách tên các repository cần inject secrets vào"
#   type        = set(string)
# }