
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = "ToeicHUST" # Organization của bạn
}

# Tạo Organization Secret tự động từ map
resource "github_actions_organization_secret" "org_secrets" {
  for_each = var.secrets

  secret_name     = each.key
  plaintext_value = each.value
  visibility      = "all" # Tùy chọn: 'all', 'private', hoặc 'selected'
}



# # --- LOGIC MỚI ---

# # 1. Tạo một biến cục bộ để "phẳng hóa" (flatten) vòng lặp lồng nhau
# # Logic: Với mỗi REPO, lặp qua tất cả SECRETS -> tạo ra danh sách tổ hợp
# locals {
#   repo_secrets = flatten([
#     for repo in var.repositories : [
#       for key, value in var.secrets : {
#         unique_id = "${repo}-${key}" # ID duy nhất để Terraform theo dõi
#         repo      = repo
#         key       = key
#         value     = value
#       }
#     ]
#   ])
# }

# # 2. Tạo Secret trong từng Repo
# resource "github_actions_secret" "repo_secret" {
#   # Chuyển list thành map với key là unique_id đã tạo ở trên
#   for_each = {
#     for item in local.repo_secrets : item.unique_id => item
#   }

#   repository      = each.value.repo
#   secret_name     = each.value.key
#   plaintext_value = each.value.value
# }