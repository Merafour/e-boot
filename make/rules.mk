
ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif


# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = $(LINKER_FILE)

# libraries
LIBS = -lc -lm -lnosys 
LIBDIR = 
LDFLAGS = $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

#######################################
# build the application
#######################################
# list of objects
#OBJECTS   += $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
OBJECTS    += $(addsuffix .o,$(addprefix $(BUILD_DIR)/,$(basename $(C_SOURCES))))
vpath %.c $(sort $(dir $(C_SOURCES)))

# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

# default action: build all
all: $(BUILD_DIR) $(OBJECTS) $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin


$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
#	@echo $^
	@mkdir -p $(dir $@)
	@echo $@
	@$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	@ mkdir -p $(dir $@)
	@$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	@ mkdir -p $(dir $@)
	@$(CC) $(OBJECTS) $(LDFLAGS) -o $@
#	@$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	@$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	@$(BIN) $< $@	
	
$(BUILD_DIR):
#	@echo $(C_SOURCES)
#	@echo $(OBJECTS)
	@mkdir -p $@		

#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)