!/bin/bash
OpenWrt DIY script part 2 (After Update feeds)
Modify default IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate
