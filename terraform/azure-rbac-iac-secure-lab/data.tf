data "azurerm_client_config" "current" {}
# ==============================================================================
# Data Sources: جلب بيانات المجموعات التشغيلية المسبقة من Azure Active Directory
# ==============================================================================

# 1. جلب بيانات مجموعة فريق تشغيل الأجهزة الافتراضية
data "azuread_group" "vm_ops_team" {
  display_name     = "grp-vm-ops-team"
  security_enabled = true
}

# 2. جلب بيانات مجموعة فريق تشغيل قواعد البيانات
data "azuread_group" "db_ops_team" {
  display_name     = "grp-db-ops-team"
  security_enabled = true
}