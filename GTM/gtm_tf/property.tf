#PROPERTY
resource "akamai_gtm_property" "karmada_setup" {
  domain                      = akamai_gtm_domain.karmada_setup.name # domain
  name                        = var.gtm_property_name            # Property Name
  type                        = "geographic"
  ipv6                        = false
  score_aggregation_type      = "worst"
  stickiness_bonus_percentage = 0
  stickiness_bonus_constant   = 0
  use_computed_targets        = false
  balance_by_download_score   = false
  dynamic_ttl                 = 300
  handout_limit               = 0
  handout_mode                = "normal"
  failover_delay              = 0
  failback_delay              = 0
  load_imbalance_percentage   = 500
  ghost_demand_reporting      = false

  traffic_target {
    datacenter_id = akamai_gtm_datacenter.us-west.datacenter_id
    enabled       = true
    weight        = 9
    servers       = [var.uswest]
    name          = "us-west"
    handout_cname = ""
  }
  traffic_target {
    datacenter_id = akamai_gtm_datacenter.eu-west.datacenter_id
    enabled       = true
    weight        = 9
    servers       = [var.euwest]
    name          = "eu-west"
    handout_cname = ""
  }
  traffic_target {
    datacenter_id = akamai_gtm_datacenter.ap-northeast.datacenter_id
    enabled       = true
    weight        = 9
    servers       = [var.apnortheast]
    name          = ""
    handout_cname = "ap-northeast"
  }
  depends_on = [
    akamai_gtm_domain.karmada_setup,
    akamai_gtm_datacenter.us-west,
    akamai_gtm_datacenter.eu-west,
    akamai_gtm_datacenter.ap-northeast
  ]
}