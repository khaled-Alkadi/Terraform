# Entra ID id
# ============
data "azurerm_client_config" "current" {}
# ==============================================================================
# Data Sources: Azure Active Directory Groups
# ==============================================================================
# 1. جلب بيانات مجموعة فريق تشغيل الأجهزة الافتراضية
data "azuread_group" "vm_ops_team" {
  display_name     = "vm_op-team"
  security_enabled = true
}
# 2. جلب بيانات مجموعة فريق تشغيل قواعد البيانات
data "azuread_group" "db_ops_team" {
  display_name     = "db-op-Team"
  security_enabled = true
}