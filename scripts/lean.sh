#!/bin/bash

rm -rf ./feeds/packages/utils/runc/Makefile
svn export https://github.com/openwrt/packages/trunk/utils/runc/Makefile ./feeds/packages/utils/runc/Makefile


rm -rf ./feeds/luci/applications/luci-app-wrtbwmon
cat ../package/build/banner >  package/base-files/files/etc/banner
cat ./package/build/profile > package/base-files/files/etc/profile
cat ./package/build/set/sysctl.conf > package/base-files/files/etc/sysctl.conf

rm -rf ./package/lean/autocore
rm -rf ./package/lean/default-settings

# Clone community packages to package/community
mkdir package/community
pushd package/community

git clone --depth=1 https://github.com/sirpdboy/build.git ./build
git clone --depth=1 https://github.com/sirpdboy/sirpdboy-package.git ./diy
# rm -rf ./package/lean/r8152
curl -fsSL  https://raw.githubusercontent.com/loso3000/other/master/patch/default-settings/zzz-default-settings1 > build/default-settings/files/zzz-default-settings

echo '替换smartdns'
rm -rf ../../customfeeds/packages/net/smartdns&& svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ../../customfeeds/packages/net/smartdns
rm -rf ../../customfeeds/luci/applications/luci-app-netdata && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata ../../customfeeds/luci/applications/luci-app-netdata
rm -rf ../../customfeeds/packages/admin/netdata && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata ../../customfeeds/packages/admin/netdata
cat build/mwan3/files/etc/config/mwan3   > ../../customfeeds/packages/net/mwan3/files/etc/config/mwan3 && rm -rf build/mwan3
rm -rf ../../customfeeds/luci/applications/luci-app-arpbind  && svn co https://github.com/sirpdboy/build/trunk/luci-app-arpbind ../../customfeeds/luci/applications/luci-app-arpbind 

rm -rf ../../customfeeds/luci/collections/luci-lib-docker
rm -rf ../../customfeeds/luci/applications/luci-app-docker
rm -rf ../../customfeeds/luci/applications/luci-app-dockerman
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-dockerman  ../../customfeeds/luci/applications/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-lib-docker

rm -rf ./luci-app-aliyundrive-webdav 
rm -rf ./aliyundrive-webdav
svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav
svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav 

# Add ddnsto & linkease
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-linkease 
svn co https://github.com/linkease/nas-packages/trunk/network/services/linkease
sed -i 's/1/0/g' linkease/files/linkease.config

#zerotier 
rm -rf ../../customfeeds/luci/applications/luci-app-zerotier
git clone https://github.com/rufengsuixing/luci-app-zerotier.git ../../customfeeds/luci/applications/luci-app-zerotier
sed -i '/45)./d' ../../customfeeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua  #zerotier
sed -i 's/vpn/services/g' ../../customfeeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua   #zerotier
sed -i 's/vpn/services/g' ../../customfeeds/luci/applications/luasrc/view/zerotier/zerotier_status.htm   #zerotier

#syncdial
rm -rf ../../customfeeds/luci/applications/luci-app-syncdial
git clone https://github.com/rufengsuixing/luci-app-syncdial.git ../../customfeeds/luci/applications/luci-app-syncdial

rm -rf ../../customfeeds/luci/applications/luci-app-baidupcs-web && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-baidupcs-web ../../customfeeds/luci/applications/luci-app-baidupcs-web

# samba4
rm -rf ../../customfeeds/luci/applications/luci-app-samba4 &&svn co https://github.com/sirpdboy/build/trunk/luci-app-samba4 ../../customfeeds/luci/applications/luci-app-samba4

git clone --depth 1 https://github.com/zxlhhyccc/luci-app-v2raya.git
svn co https://github.com/v2rayA/v2raya-openwrt/trunk/v2raya

git clone --depth=1 https://github.com/immortalwrt/luci-app-unblockneteasemusic.git
sed -i 's/解除网易云音乐播放限制/解锁灰色歌曲/g' luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua

git clone --depth=1 https://github.com/kiddin9/luci-app-dnsfilter

echo '替换aria2'
rm -rf ../../customfeeds/luci/applications/luci-app-aria2 && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-aria2 ../../customfeeds/luci/applications/luci-app-aria2
rm -rf ../../customfeeds/packages/net/aria2 && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/net/aria2 ../../customfeeds/packages/net/aria2

git clone --depth=1 https://github.com/QiuSimons/openwrt-mos
sed -i "/filter_aaaa='1'/d" openwrt-mos/luci-app-mosdns/root/etc/init.d/mosdns

#koolproxy
git clone --depth=1 https://github.com/iwrt/luci-app-ikoolproxy.git
sed -i 's,1).dep,11).dep,g' ./luci-app-ikoolproxy/luasrc/controller/koolproxy.lua 

git clone --depth=1 -b master https://github.com/vernesong/OpenClash

# Add OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter


# Passwall
rm -rf ../../customfeeds/packages/net/pdnsd-alt
rm -rf ../../customfeeds/packages/net/shadowsocks-libev
rm -rf ../../customfeeds/packages/net/xray-core
rm -rf ../../customfeeds/packages/net/kcptun
rm -rf ../../customfeeds/packages/net/brook
rm -rf ../../customfeeds/packages/net/chinadns-ng
rm -rf ../../customfeeds/packages/net/dns2socks
rm -rf ../../customfeeds/packages/net/hysteria
rm -rf ../../customfeeds/packages/net/ipt2socks
rm -rf ../../customfeeds/packages/net/microsocks
rm -rf ../../customfeeds/packages/net/naiveproxy
rm -rf ../../customfeeds/packages/net/shadowsocks-rust
rm -rf ../../customfeeds/packages/net/simple-obfs
rm -rf ../../customfeeds/packages/net/ssocks
rm -rf ../../customfeeds/packages/net/tcping
rm -rf ../../customfeeds/packages/net/v2ray*
rm -rf ../../customfeeds/packages/net/xray*
rm -rf ../../customfeeds/packages/net/trojan*

#git clone https://github.com/kenzok8/small
#git clone https://github.com/xiaorouji/openwrt-passwall.git package/passs
#git clone https://github.com/xiaorouji/openwrt-passwall2.git 
#  git clone https://github.com/loso3000/openwrt-passwall package/passwall
# svn co https://github.com/loso3000/openwrt-passwall/trunk/luci-app-passwall
git clone --depth=1 https://github.com/fw876/helloworld.git

rm -rf diy/luci-theme-edge
rm -rf ../../customfeeds/luci/themes/luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone -b 18.06  https://github.com/kiddin9/luci-theme-edge.git

# Add cpufreq
rm -rf ../../customfeeds/luci/applications/luci-app-cpufreq
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq
sed -i 's,1608,1800,g' luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,2016,2208,g' luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,1512,1608,g' luci-app-cpufreq/root/etc/uci-defaults/cpufreq
popd

rm -rf ./package/lean/ddns-scripts_aliyun && \
svn co https://github.com/sirpdboy/build/trunk/ddns-scripts_aliyun package/lean/ddns-scripts_aliyun


# 使用默认取消自动
# sed -i "s/bootstrap/chuqitopd/g" feeds/luci/modules/luci-base/root/etc/config/luci
# sed -i 's/bootstrap/chuqitopd/g' feeds/luci/collections/luci/Makefile
echo "修改默认主题"
sed -i 's/+luci-theme-bootstrap/+luci-theme-opentopd/g' customfeeds/luci/collections/luci/Makefile
# sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# version=$(grep "DISTRIB_REVISION=" package/lean/default-settings/files/zzz-default-settings  | awk -F "'" '{print $2}')
# sed -i '/root:/d' ./package/base-files/files/etc/shadow
# sed -i 's/root::0:0:99999:7:::/root:$1$tzMxByg.$e0847wDvo3JGW4C3Qqbgb.:19052:0:99999:7:::/g' ./package/base-files/files/etc/shadow   #tiktok
# sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' ./package/base-files/files/etc/shadow    #password

#sed -i 's/US/CN/g ; s/OpenWrt/iNet/g ; s/none/psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# sed -i "s/hostname='OpenWrt'/hostname='${HOSTNAME}'/g" package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.4/g' ./target/linux/*/Makefile
sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=5.4/g' ./target/linux/*/Makefile

# Fix SDK
sed -i '/$(SDK_BUILD_DIR)\/$(STAGING_SUBDIR_HOST)\/usr\/bin/d;/LICENSE/d' ./target/sdk/Makefile

#修正连接数 
# sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf
# 最大连接数
sed -i 's/65535/165535/g' ./package/kernel/linux/files/sysctl-nf-conntrack.conf

#echo "其他修改"
sed -i 's/option commit_interval 24h/option commit_interval 2h/g' customfeeds/packages/net/nlbwmon/files/nlbwmon.config #修改流量统计写入为2
sed -i 's#option database_directory /var/lib/nlbwmon#option database_directory /etc/config/nlbwmon_data#g' customfeeds/packages/net/nlbwmon/files/nlbwmon.config #修改流量统计数据存放默认位置

echo '添加关机'
curl -fsSL  https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/poweroff.htm > customfeeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/system.lua > customfeeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

sed -i 's/"Argon 主题设置"/"Argon设置"/g' `grep "Argon 主题设置" -rl ./`
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' `grep "Turbo ACC 网络加速" -rl ./`
sed -i 's/"网络存储"/"存储"/g' `grep "网络存储" -rl ./`
sed -i 's/"USB 打印服务器"/"打印服务"/g' `grep "USB 打印服务器" -rl ./`
sed -i 's/"带宽监控"/"监控"/g' `grep "带宽监控" -rl ./`
sed -i 's/实时流量监测/流量/g'  `grep "实时流量监测" -rl ./`
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g'  `grep "解锁网易云灰色歌曲" -rl ./`
sed -i 's/解除网易云音乐播放限制/解锁灰色歌曲/g'  `grep "解除网易云音乐播放限制" -rl ./`
sed -i 's/家庭云//g'  `grep "家庭云" -rl ./`

sed -i 's/aMule设置/电驴下载/g' customfeeds/luci/applications/luci-app-amule/po/zh-cn/amule.po
sed -i 's/监听端口/监听端口 用户名admin密码adminadmin/g' customfeeds/luci/applications/luci-app-qbittorrent/po/zh-cn/qbittorrent.po

sed -i 's/a.default = "0"/a.default = "1"/g' customfeeds/luci/applications/luci-app-cifsd/luasrc/controller/cifsd.lua   #挂问题
sed -i 's/invalid/# invalid/g' ./package/network/services/samba36/files/smb.conf.template  #共享问题
sed -i '/mcsub_renew.datatype/d'  customfeeds/luci/applications/luci-app-udpxy/luasrc/model/cbi/udpxy.lua  #修复UDPXY设置延时55的错误
sed -i '/filter_/d' ./package/network/services/dnsmasq/files/dhcp.conf   #DHCP禁用IPV6问题
sed -i 's/请输入用户名和密码。/欢迎使用!请输入用户密码~/g' customfeeds/luci/modules/luci-base/po/zh-cn/base.po   #用户名密码

VER2="$(grep "KERNEL_PATCHVER:="  ./target/linux/x86/Makefile | cut -d = -f 2)"

date1='Ipv6-Plus-S'`TZ=UTC-8 date +%Y.%m.%d -d +"12"hour`

date1='Ipv6-Plus-S2022.03.24'
sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/20220324-Ipv6-Plus-5.4-/g' include/image.mk
if [ "$VER2" = "5.4" ]; then
    sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/$(shell TZ=UTC-8 date +%Y%m%d -d +12hour)-Ipv6-Plus-5.4-/g' include/image.mk
elif [ "$VER2" = "5.10" ]; then
    sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/$(shell TZ=UTC-8 date +%Y%m%d -d +12hour)-Ipv6-Plus-5.10-/g' include/image.mk
elif [ "$VER2" = "5.15" ]; then
    sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/$(shell TZ=UTC-8 date +%Y%m%d -d +12hour)-Ipv6-Plus-5.15-/g' include/image.mk
fi
echo "DISTRIB_REVISION='${date1} by Sirpdboy'" > ./package/base-files/files/etc/openwrt_release1
echo ${date1}' by Sirpdboy ' >> ./package/base-files/files/etc/banner
echo '---------------------------------' >> ./package/base-files/files/etc/banner

./scripts/feeds update -i
