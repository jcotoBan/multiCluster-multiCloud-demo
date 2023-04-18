#DATACENTER

resource "akamai_gtm_datacenter" "us-west" {
  domain                            = akamai_gtm_domain.karmada_setup.name # domain
  nickname                          = "us-west"                        # Datacenter Nickname
  city                              = "Freemont"
  continent                         = "NA"
  country                           = "US"
  cloud_server_host_header_override = false
  cloud_server_targeting            = false
  depends_on                        = [akamai_gtm_domain.karmada_setup]
}

resource "akamai_gtm_datacenter" "eu-west" {
  domain                            = akamai_gtm_domain.karmada_setup.name # domain
  nickname                          = "eu-west"                        # Datacenter Nickname
  city                              = "London"
  continent                         = "EU"
  country                           = "UK"
  cloud_server_host_header_override = false
  cloud_server_targeting            = false
  depends_on                        = [akamai_gtm_domain.karmada_setup]
}

resource "akamai_gtm_datacenter" "ap-northeast" {
  domain                            = akamai_gtm_domain.karmada_setup.name # domain
  nickname                          = "ap-northeast"                   # Datacenter Nickname
  city                              = "Tokyo"
  continent                         = "AS"
  country                           = "JP"
  cloud_server_host_header_override = false
  cloud_server_targeting            = false
  depends_on                        = [akamai_gtm_domain.karmada_setup]
}