resource "aws_budgets_budget" "budget-limit" {
  name              = "monthly-budget"
  budget_type       = "COST"
  limit_amount      = "5.0"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2020-12-14_02:30"
}