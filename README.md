# OpenWrt factory image creator for Sercomm AD1018
Create an Openwrt encrypted factory image for the Sercomm AD1018 router. This image can be  
flashed using the factory web UI.

Instructions:  

1. Drop the openwrt non-encrypted firmware into this directory.
2. Execute the build.sh script, this will generate the *openwrt-sercomm_ad1018-factory_3013.img*:  
    `./build.sh`
3. From the busybox CLI at the router execute these commands to boot the 2nd firmware:  
    `flash_eraseall /dev/mtd8`  
    `flash_eraseall /dev/mtd9`  
    `echo -n "eRcOmM.000" | dd of=/dev/mtdblock8`  
    `echo -n "eRcOmM.001" | dd of=/dev/mtdblock9`  
    `reboot`
4. Flash the *sercomm_ad1018-factory_3013.img* image using the factory web UI.
