resource "azurerm_resource_group" "sec_score_export_rg" {
  count    = var.export_to_workspace_ID != null ? 1 : 0
  name     = var.sec_score_export_rg
  location = var.location
}

resource "azurerm_security_center_automation" "export_to_workspace" {
  count               = var.export_to_workspace_ID != null ? 1 : 0
  name                = "ExportToWorkspace"
  location            = var.location
  resource_group_name = var.sec_score_export_rg
  scopes              = [data.azurerm_subscription.current.id]

  action {
    type        = "loganalytics"
    resource_id = var.export_to_workspace_ID
  }

  source {
    event_source = "Assessments"
    rule_set {
      rule {
        expected_value = "Microsoft.Security/assessments"
        operator       = "Contains"
        property_path  = "type"
        property_type  = "String"
      }
    }
  }
  source {
    event_source = "AssessmentsSnapshot"
    rule_set {
      rule {
        expected_value = "Microsoft.Security/assessments"
        operator       = "Contains"
        property_path  = "type"
        property_type  = "String"
      }
    }
  }
  source {
    event_source = "SubAssessments"
  }
  source {
    event_source = "SubAssessmentsSnapshot"
  }
  source {
    event_source = "Alerts"
    rule_set {
      rule {
        expected_value = "low"
        operator       = "Equals"
        property_path  = "Severity"
        property_type  = "String"
      }
    }
    rule_set {
      rule {
        expected_value = "medium"
        operator       = "Equals"
        property_path  = "Severity"
        property_type  = "String"
      }
    }
    rule_set {
      rule {
        expected_value = "high"
        operator       = "Equals"
        property_path  = "Severity"
        property_type  = "String"
      }
    }
    rule_set {
      rule {
        expected_value = "informational"
        operator       = "Equals"
        property_path  = "Severity"
        property_type  = "String"
      }
    }
  }
  source {
    event_source = "SecureScores"
  }
  source {
    event_source = "SecureScoresSnapshot"
  }
  source {
    event_source = "SecureScoreControls"
  }
  source {
    event_source = "SecureScoreControlsSnapshot"
  }
  source {
    event_source = "RegulatoryComplianceAssessment"
  }
  source {
    event_source = "RegulatoryComplianceAssessmentSnapshot"
  }
}