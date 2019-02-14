
TEST_SOURCES = 

ifeq ($(TARGET_HW),GS700)
# C sources
TEST_SOURCES =  \
$(HW_LIB)/Src/main.c \
$(HW_LIB)/Src/gpio.c \
$(HW_LIB)/Src/i2c.c \
$(HW_LIB)/Src/usart.c \
$(HW_LIB)/Src/usb_device.c \
$(HW_LIB)/Src/usbd_conf.c \
$(HW_LIB)/Src/usbd_desc.c \
$(HW_LIB)/Src/usbd_cdc_if.c \
$(HW_LIB)/Src/stm32l0xx_it.c \
$(HW_LIB)/Src/stm32l0xx_hal_msp.c \
$(HW_LIB)/Src/system_stm32l0xx.c \
$(HW_LIB)/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_core.c \
$(HW_LIB)/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ctlreq.c \
$(HW_LIB)/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ioreq.c \
$(HW_LIB)/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Src/usbd_cdc.c  
endif
ifeq ($(TARGET_HW),GS600AD_04_29)
# C sources
TEST_SOURCES =  \
$(HW_LIB)/Src/main.c \
$(HW_LIB)/Src/gpio.c \
$(HW_LIB)/Src/adc.c \
$(HW_LIB)/Src/i2c.c \
$(HW_LIB)/Src/iwdg.c \
$(HW_LIB)/Src/tim.c \
$(HW_LIB)/Src/usart.c \
$(HW_LIB)/Src/wwdg.c \
$(HW_LIB)/Src/stm32f4xx_it.c \
$(HW_LIB)/Src/stm32f4xx_hal_msp.c \
$(HW_LIB)/Src/system_stm32f4xx.c 
endif

C_SOURCES += $(TEST_SOURCES)




