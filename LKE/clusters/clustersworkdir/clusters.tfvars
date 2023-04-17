/**************************/

region_manager_lke_cluster = [
    {
        label : "region_manager_lke_cluster"
        k8s_version : "1.25"
        region : "us-southeast"
        pools = [
            {
                type : "g6-standard-2"
                count : 1
            }
        ]
    }
]

/**************************/

us_lke_cluster = [
    {
        label : "us_lke_cluster"
        k8s_version : "1.25"
        region : "us-west"
        pools = [
            {
                type : "g6-standard-2"
                count : 1
            }
        ]
    }
]


/****************************************/
eu_lke_cluster = [
    {
        label : "eu_lke_cluster"
        k8s_version : "1.25"
        region : "eu-west"
        pools = [
            {
                type : "g6-standard-2"
                count : 1
            }
        ]
    }
]

/****************************************/
ap_lke_cluster = [
    {
        label : "ap_lke_cluster"
        k8s_version : "1.25"
        region : "ap-northeast"
        pools = [
            {
                type : "g6-standard-2"
                count : 1
            }
        ]
    }
]

