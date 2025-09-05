terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.44.0"
    }
  }
}

provider "huaweicloud" {
  access_key = "HPUAH59MMWAVTYNIZMCY"
  secret_key = "EeNCp1bgeSXTEYV3F6Mp9Y86FEswuvR7JE2SoLDi"
  region     = "ap-southeast-3"
  project_id = "f626eb8d6513487c8f0ccc413e1af771"
}
