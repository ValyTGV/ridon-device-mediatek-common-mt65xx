
$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
		$(recovery_ramdisk) \
		$(recovery_kernel)
	@echo ----- Making MTK recovery image ------
	BOARD_KERNEL_CMDLINE="$(BOARD_KERNEL_CMDLINE)" perl device/mediatek/common-65xx/mtk-tools/repack-MTK.pl -recovery $(recovery_kernel) $(TARGET_RECOVERY_ROOT_OUT) $@
	@echo ----- Made recovery image -------- $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)


$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES) static_busybox
	@echo ----- Making MTK boot image ------
	$(call pretty,"Target boot image: $@")
	BOARD_KERNEL_CMDLINE="$(BOARD_KERNEL_CMDLINE)" perl device/mediatek/common-65xx/mtk-tools/repack-MTK.pl -boot --debug $(recovery_kernel) $(PRODUCT_OUT)/root $@ 
	@echo ----- Made boot image -------- $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
