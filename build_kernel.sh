curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s v0.9.5

export PATH="/home/ubuntu/arm-linux-androideabi-4.9/bin:/home/ubuntu/aarch64-linux-android-4.9/bin:$PATH"

make mrproper
make ARCH=arm64 SUBARCH=arm64 O=out CC=clang CROSS_COMPILE=aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi- CLANG_TRIPLE=aarch64-linux-gnu- lmi_defconfig
make ARCH=arm64 SUBARCH=arm64 O=out CC=clang CROSS_COMPILE=aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi- CLANG_TRIPLE=aarch64-linux-gnu- -j8

find out/arch/arm64/boot/dts -name '*.dtb' -exec cat {} + >out/arch/arm64/boot/dtb

git clone https://github.com/TheVoyager0777/AnyKernel3.git -b kona --depth=1 anykernel

rm -rf anykernel/kernels/miui
rm -rf anykernel/kernels/aosp

mkdir -p anykernel/kernels/miui
mkdir -p anykernel/kernels/aosp

cp out/arch/arm64/boot/Image anykernel/kernels/miui
cp out/arch/arm64/boot/dtb anykernel/kernels/miui
cp out/arch/arm64/boot/dtbo.img anykernel/kernels/miui


cp out/arch/arm64/boot/Image anykernel/kernels/aosp
cp out/arch/arm64/boot/dtb anykernel/kernels/aosp
cp out/arch/arm64/boot/dtbo.img anykernel/kernels/aosp

cd anykernel 
zip -r9 "Kernel_$(date +'%Y%m%d_%H%M%S')_anykernel3.zip" ./* -x .git .gitignore out/ ./*.zip


#custom 
CONFIG_PROCESS_RECLAIM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
#MIUI 

CONFIG_KSU=y
CONFIG_ARM_ARCH_TIMER_VCT_ACCESS=y
CONFIG_F2FS_UNFAIR_RWSEM=y
# CONFIG_MIHW=y
CONFIG_KCAL=y
CONFIG_PERF_CRITICAL_RT_TASK=y
CONFIG_SF_BINDER=y
CONFIG_FCMA=y
CONFIG_CFS_BANDWITH=y
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
CONFIG_FEAS=y
CONFIG_QCOM_HYP_CORE_CTL=y
CONFIG_EXTEND_RECLAIM=y
CONFIG_MIUI_ZRAM_MEMORY_TRACKING=y
CONFIG_MI_MEMORY_SYSFS=y
CONFIG_UFSRINGBUF=y
CONFIG_UFSHID=y
CONFIG_MILLET=y