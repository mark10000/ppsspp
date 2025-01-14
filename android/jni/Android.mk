LOCAL_PATH := $(call my-dir)

# BEGIN Native Audio Separate Library - copy paste this section to your Android.mk

include $(CLEAR_VARS)

LOCAL_MODULE := native_audio
LOCAL_CFLAGS := -O3 -fsigned-char -Wall -Wno-multichar -Wno-psabi -D__STDC_CONSTANT_MACROS
# yes, it's really CPPFLAGS for C++
LOCAL_CPPFLAGS := -fno-exceptions -std=gnu++11 -fno-rtti
NATIVE := ../../native
LOCAL_SRC_FILES := \
		$(NATIVE)/android/native-audio-so.cpp
LOCAL_C_INCLUDES := \
		$(LOCAL_PATH)/$(NATIVE) \
		$(LOCAL_PATH)
LOCAL_LDLIBS := -lOpenSLES -llog
		
include $(BUILD_SHARED_LIBRARY)

# END Native Audio Separate Library - copy paste this section to your Android.mk

include $(CLEAR_VARS)

#TARGET_PLATFORM := android-8

NATIVE := ../../native
SRC := ../..

include $(LOCAL_PATH)/Locals.mk

# http://software.intel.com/en-us/articles/getting-started-on-optimizing-ndk-project-for-multiple-cpu-architectures

ifeq ($(TARGET_ARCH_ABI),x86)
ARCH_FILES := \
  $(SRC)/Common/ABI.cpp \
  $(SRC)/Common/x64Emitter.cpp \
  $(SRC)/Common/CPUDetect.cpp \
  $(SRC)/Common/Thunk.cpp \
  $(SRC)/Core/MIPS/x86/CompALU.cpp \
  $(SRC)/Core/MIPS/x86/CompBranch.cpp \
  $(SRC)/Core/MIPS/x86/CompFPU.cpp \
  $(SRC)/Core/MIPS/x86/CompLoadStore.cpp \
  $(SRC)/Core/MIPS/x86/CompVFPU.cpp \
  $(SRC)/Core/MIPS/x86/CompReplace.cpp \
  $(SRC)/Core/MIPS/x86/Asm.cpp \
  $(SRC)/Core/MIPS/x86/Jit.cpp \
  $(SRC)/Core/MIPS/x86/JitSafeMem.cpp \
  $(SRC)/Core/MIPS/x86/RegCache.cpp \
  $(SRC)/Core/MIPS/x86/RegCacheFPU.cpp \
  $(SRC)/GPU/Common/VertexDecoderX86.cpp
endif

ifeq ($(findstring armeabi-v7a,$(TARGET_ARCH_ABI)),armeabi-v7a)
ARCH_FILES := \
  $(SRC)/GPU/Common/TextureDecoderNEON.cpp.neon \
  $(SRC)/Core/Util/AudioFormatNEON.cpp.neon \
  $(SRC)/Common/ArmEmitter.cpp \
  $(SRC)/Common/ArmCPUDetect.cpp \
  $(SRC)/Common/ArmThunk.cpp \
  $(SRC)/Common/ColorConvNEON.cpp.neon \
  $(SRC)/Core/MIPS/ARM/ArmCompALU.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompBranch.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompFPU.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompLoadStore.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompVFPU.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompVFPUNEON.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompVFPUNEONUtil.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompReplace.cpp \
  $(SRC)/Core/MIPS/ARM/ArmAsm.cpp \
  $(SRC)/Core/MIPS/ARM/ArmJit.cpp \
  $(SRC)/Core/MIPS/ARM/ArmRegCache.cpp \
  $(SRC)/Core/MIPS/ARM/ArmRegCacheFPU.cpp \
  $(SRC)/GPU/Common/VertexDecoderArm.cpp \
  $(SRC)/ext/disarm.cpp \
  ArmEmitterTest.cpp
endif

ifeq ($(findstring arm64-v8a,$(TARGET_ARCH_ABI)),arm64-v8a)
ARCH_FILES := \
  $(SRC)/GPU/Common/TextureDecoderNEON.cpp \
  $(SRC)/Core/Util/AudioFormatNEON.cpp \
  $(SRC)/Common/Arm64Emitter.cpp \
  $(SRC)/Common/ArmCPUDetect.cpp \
  $(SRC)/Common/ColorConvNEON.cpp \
  $(SRC)/Core/MIPS/ARM64/Arm64CompALU.cpp \
  $(SRC)/Core/MIPS/ARM64/Arm64CompBranch.cpp \
  $(SRC)/Core/MIPS/ARM64/Arm64CompFPU.cpp \
  $(SRC)/Core/MIPS/ARM64/Arm64CompLoadStore.cpp \
  $(SRC)/Core/MIPS/ARM64/Arm64CompVFPU.cpp \
  $(SRC)/Core/MIPS/ARM64/Arm64CompReplace.cpp \
  $(SRC)/Core/MIPS/ARM64/Arm64Asm.cpp \
  $(SRC)/Core/MIPS/ARM64/Arm64Jit.cpp \
  $(SRC)/Core/MIPS/ARM64/Arm64RegCache.cpp \
  $(SRC)/Core/MIPS/ARM64/Arm64RegCacheFPU.cpp \
  $(SRC)/Core/Util/DisArm64.cpp \
  $(SRC)/GPU/Common/VertexDecoderArm64.cpp \
  Arm64EmitterTest.cpp
endif

ifeq ($(TARGET_ARCH_ABI),armeabi)
ARCH_FILES := \
  $(SRC)/Common/ArmEmitter.cpp \
  $(SRC)/Common/ArmCPUDetect.cpp \
  $(SRC)/Common/ArmThunk.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompALU.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompBranch.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompFPU.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompLoadStore.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompVFPU.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompVFPUNEON.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompVFPUNEONUtil.cpp \
  $(SRC)/Core/MIPS/ARM/ArmCompReplace.cpp \
  $(SRC)/Core/MIPS/ARM/ArmAsm.cpp \
  $(SRC)/Core/MIPS/ARM/ArmJit.cpp \
  $(SRC)/Core/MIPS/ARM/ArmRegCache.cpp \
  $(SRC)/Core/MIPS/ARM/ArmRegCacheFPU.cpp \
  $(SRC)/GPU/Common/VertexDecoderArm.cpp \
  ArmEmitterTest.cpp
endif

EXEC_AND_LIB_FILES := \
  $(ARCH_FILES) \
  TestRunner.cpp \
  $(SRC)/Core/MIPS/MIPS.cpp.arm \
  $(SRC)/Core/MIPS/MIPSAnalyst.cpp \
  $(SRC)/Core/MIPS/MIPSDis.cpp \
  $(SRC)/Core/MIPS/MIPSDisVFPU.cpp \
  $(SRC)/Core/MIPS/MIPSInt.cpp.arm \
  $(SRC)/Core/MIPS/MIPSIntVFPU.cpp.arm \
  $(SRC)/Core/MIPS/MIPSStackWalk.cpp \
  $(SRC)/Core/MIPS/MIPSTables.cpp \
  $(SRC)/Core/MIPS/MIPSVFPUUtils.cpp.arm \
  $(SRC)/Core/MIPS/MIPSCodeUtils.cpp.arm \
  $(SRC)/Core/MIPS/MIPSDebugInterface.cpp \
  $(SRC)/UI/ui_atlas.cpp \
  $(SRC)/UI/OnScreenDisplay.cpp \
  $(SRC)/ext/libkirk/AES.c \
  $(SRC)/ext/libkirk/amctrl.c \
  $(SRC)/ext/libkirk/SHA1.c \
  $(SRC)/ext/libkirk/bn.c \
  $(SRC)/ext/libkirk/ec.c \
  $(SRC)/ext/libkirk/kirk_engine.c \
  $(SRC)/ext/sfmt19937/SFMT.c \
  $(SRC)/ext/snappy/snappy-c.cpp \
  $(SRC)/ext/snappy/snappy.cpp \
  $(SRC)/ext/udis86/decode.c \
  $(SRC)/ext/udis86/itab.c \
  $(SRC)/ext/udis86/syn-att.c \
  $(SRC)/ext/udis86/syn-intel.c \
  $(SRC)/ext/udis86/syn.c \
  $(SRC)/ext/udis86/udis86.c \
  $(SRC)/ext/xbrz/xbrz.cpp \
  $(SRC)/ext/xxhash.c \
  $(SRC)/Common/Crypto/md5.cpp \
  $(SRC)/Common/Crypto/sha1.cpp \
  $(SRC)/Common/Crypto/sha256.cpp \
  $(SRC)/Common/ChunkFile.cpp \
  $(SRC)/Common/ColorConv.cpp \
  $(SRC)/Common/KeyMap.cpp \
  $(SRC)/Common/LogManager.cpp \
  $(SRC)/Common/MemArena.cpp \
  $(SRC)/Common/MemoryUtil.cpp \
  $(SRC)/Common/MsgHandler.cpp \
  $(SRC)/Common/FileUtil.cpp \
  $(SRC)/Common/StringUtils.cpp \
  $(SRC)/Common/ThreadPools.cpp \
  $(SRC)/Common/Timer.cpp \
  $(SRC)/Common/Misc.cpp \
  $(SRC)/GPU/Math3D.cpp \
  $(SRC)/GPU/GPUCommon.cpp \
  $(SRC)/GPU/GPUState.cpp \
  $(SRC)/GPU/GeDisasm.cpp \
  $(SRC)/GPU/Common/DepalettizeShaderCommon.cpp \
  $(SRC)/GPU/Common/FramebufferCommon.cpp \
  $(SRC)/GPU/Common/IndexGenerator.cpp.arm \
  $(SRC)/GPU/Common/SoftwareTransformCommon.cpp.arm \
  $(SRC)/GPU/Common/VertexDecoderCommon.cpp.arm \
  $(SRC)/GPU/Common/TextureCacheCommon.cpp.arm \
  $(SRC)/GPU/Common/TextureScalerCommon.cpp.arm \
  $(SRC)/GPU/Common/SplineCommon.cpp.arm \
  $(SRC)/GPU/Common/DrawEngineCommon.cpp.arm \
  $(SRC)/GPU/Common/TransformCommon.cpp.arm \
  $(SRC)/GPU/Common/TextureDecoder.cpp \
  $(SRC)/GPU/Common/PostShader.cpp \
  $(SRC)/GPU/Debugger/Breakpoints.cpp \
  $(SRC)/GPU/Debugger/Stepping.cpp \
  $(SRC)/GPU/GLES/Framebuffer.cpp \
  $(SRC)/GPU/GLES/DepalettizeShader.cpp \
  $(SRC)/GPU/GLES/GLES_GPU.cpp.arm \
  $(SRC)/GPU/GLES/StencilBuffer.cpp.arm \
  $(SRC)/GPU/GLES/TextureCache.cpp.arm \
  $(SRC)/GPU/GLES/TransformPipeline.cpp.arm \
  $(SRC)/GPU/GLES/StateMapping.cpp.arm \
  $(SRC)/GPU/GLES/ShaderManager.cpp.arm \
  $(SRC)/GPU/GLES/VertexShaderGenerator.cpp.arm \
  $(SRC)/GPU/GLES/FragmentShaderGenerator.cpp.arm \
  $(SRC)/GPU/GLES/FragmentTestCache.cpp.arm \
  $(SRC)/GPU/GLES/TextureScaler.cpp \
  $(SRC)/GPU/Null/NullGpu.cpp \
  $(SRC)/GPU/Software/Clipper.cpp \
  $(SRC)/GPU/Software/Lighting.cpp \
  $(SRC)/GPU/Software/Rasterizer.cpp.arm \
  $(SRC)/GPU/Software/SoftGpu.cpp \
  $(SRC)/GPU/Software/TransformUnit.cpp \
  $(SRC)/Core/ELF/ElfReader.cpp \
  $(SRC)/Core/ELF/PBPReader.cpp \
  $(SRC)/Core/ELF/PrxDecrypter.cpp \
  $(SRC)/Core/ELF/ParamSFO.cpp \
  $(SRC)/Core/HW/SimpleAudioDec.cpp \
  $(SRC)/Core/HW/AsyncIOManager.cpp \
  $(SRC)/Core/HW/MemoryStick.cpp \
  $(SRC)/Core/HW/MpegDemux.cpp.arm \
  $(SRC)/Core/HW/MediaEngine.cpp.arm \
  $(SRC)/Core/HW/SasAudio.cpp.arm \
  $(SRC)/Core/HW/StereoResampler.cpp.arm \
  $(SRC)/Core/Core.cpp \
  $(SRC)/Core/Config.cpp \
  $(SRC)/Core/CoreTiming.cpp \
  $(SRC)/Core/CwCheat.cpp \
  $(SRC)/Core/HDRemaster.cpp \
  $(SRC)/Core/Host.cpp \
  $(SRC)/Core/Loaders.cpp \
  $(SRC)/Core/PSPLoaders.cpp \
  $(SRC)/Core/FileLoaders/CachingFileLoader.cpp \
  $(SRC)/Core/FileLoaders/DiskCachingFileLoader.cpp \
  $(SRC)/Core/FileLoaders/HTTPFileLoader.cpp \
  $(SRC)/Core/FileLoaders/LocalFileLoader.cpp \
  $(SRC)/Core/FileLoaders/RetryingFileLoader.cpp \
  $(SRC)/Core/MemMap.cpp \
  $(SRC)/Core/MemMapFunctions.cpp \
  $(SRC)/Core/Reporting.cpp \
  $(SRC)/Core/SaveState.cpp \
  $(SRC)/Core/Screenshot.cpp \
  $(SRC)/Core/System.cpp \
  $(SRC)/Core/Debugger/Breakpoints.cpp \
  $(SRC)/Core/Debugger/SymbolMap.cpp \
  $(SRC)/Core/Dialog/PSPDialog.cpp \
  $(SRC)/Core/Dialog/PSPGamedataInstallDialog.cpp \
  $(SRC)/Core/Dialog/PSPMsgDialog.cpp \
  $(SRC)/Core/Dialog/PSPNetconfDialog.cpp \
  $(SRC)/Core/Dialog/PSPOskDialog.cpp \
  $(SRC)/Core/Dialog/PSPScreenshotDialog.cpp \
  $(SRC)/Core/Dialog/PSPPlaceholderDialog.cpp \
  $(SRC)/Core/Dialog/PSPSaveDialog.cpp \
  $(SRC)/Core/Dialog/SavedataParam.cpp \
  $(SRC)/Core/Font/PGF.cpp \
  $(SRC)/Core/HLE/HLEHelperThread.cpp \
  $(SRC)/Core/HLE/HLETables.cpp \
  $(SRC)/Core/HLE/ReplaceTables.cpp \
  $(SRC)/Core/HLE/HLE.cpp \
  $(SRC)/Core/HLE/sceAdler.cpp \
  $(SRC)/Core/HLE/sceAtrac.cpp \
  $(SRC)/Core/HLE/__sceAudio.cpp.arm \
  $(SRC)/Core/HLE/sceAudio.cpp.arm \
  $(SRC)/Core/HLE/sceAudiocodec.cpp.arm \
  $(SRC)/Core/HLE/sceAudioRouting.cpp \
  $(SRC)/Core/HLE/sceChnnlsv.cpp \
  $(SRC)/Core/HLE/sceCcc.cpp \
  $(SRC)/Core/HLE/sceCtrl.cpp.arm \
  $(SRC)/Core/HLE/sceDeflt.cpp \
  $(SRC)/Core/HLE/sceDisplay.cpp \
  $(SRC)/Core/HLE/sceDmac.cpp \
  $(SRC)/Core/HLE/sceG729.cpp \
  $(SRC)/Core/HLE/sceGe.cpp \
  $(SRC)/Core/HLE/sceFont.cpp \
  $(SRC)/Core/HLE/sceHeap.cpp \
  $(SRC)/Core/HLE/sceHprm.cpp \
  $(SRC)/Core/HLE/sceHttp.cpp \
  $(SRC)/Core/HLE/sceImpose.cpp \
  $(SRC)/Core/HLE/sceIo.cpp \
  $(SRC)/Core/HLE/sceJpeg.cpp \
  $(SRC)/Core/HLE/sceKernel.cpp \
  $(SRC)/Core/HLE/sceKernelAlarm.cpp \
  $(SRC)/Core/HLE/sceKernelEventFlag.cpp \
  $(SRC)/Core/HLE/sceKernelInterrupt.cpp \
  $(SRC)/Core/HLE/sceKernelMemory.cpp \
  $(SRC)/Core/HLE/sceKernelModule.cpp \
  $(SRC)/Core/HLE/sceKernelMutex.cpp \
  $(SRC)/Core/HLE/sceKernelMbx.cpp \
  $(SRC)/Core/HLE/sceKernelMsgPipe.cpp \
  $(SRC)/Core/HLE/sceKernelSemaphore.cpp \
  $(SRC)/Core/HLE/sceKernelThread.cpp.arm \
  $(SRC)/Core/HLE/sceKernelTime.cpp \
  $(SRC)/Core/HLE/sceKernelVTimer.cpp \
  $(SRC)/Core/HLE/sceMpeg.cpp \
  $(SRC)/Core/HLE/sceMd5.cpp \
  $(SRC)/Core/HLE/sceMp4.cpp \
  $(SRC)/Core/HLE/sceMp3.cpp \
  $(SRC)/Core/HLE/sceNet.cpp \
  $(SRC)/Core/HLE/proAdhoc.cpp \
  $(SRC)/Core/HLE/proAdhocServer.cpp \
  $(SRC)/Core/HLE/sceNetAdhoc.cpp \
  $(SRC)/Core/HLE/sceOpenPSID.cpp \
  $(SRC)/Core/HLE/sceP3da.cpp \
  $(SRC)/Core/HLE/sceMt19937.cpp \
  $(SRC)/Core/HLE/sceParseHttp.cpp \
  $(SRC)/Core/HLE/sceParseUri.cpp \
  $(SRC)/Core/HLE/scePower.cpp \
  $(SRC)/Core/HLE/sceRtc.cpp \
  $(SRC)/Core/HLE/scePsmf.cpp \
  $(SRC)/Core/HLE/sceSas.cpp \
  $(SRC)/Core/HLE/sceSfmt19937.cpp \
  $(SRC)/Core/HLE/sceSha256.cpp \
  $(SRC)/Core/HLE/sceSsl.cpp \
  $(SRC)/Core/HLE/sceUmd.cpp \
  $(SRC)/Core/HLE/sceUsb.cpp \
  $(SRC)/Core/HLE/sceUsbGps.cpp \
  $(SRC)/Core/HLE/sceUtility.cpp \
  $(SRC)/Core/HLE/sceVaudio.cpp \
  $(SRC)/Core/HLE/scePspNpDrm_user.cpp \
  $(SRC)/Core/HLE/sceGameUpdate.cpp \
  $(SRC)/Core/HLE/sceNp.cpp \
  $(SRC)/Core/HLE/scePauth.cpp \
  $(SRC)/Core/FileSystems/BlockDevices.cpp \
  $(SRC)/Core/FileSystems/ISOFileSystem.cpp \
  $(SRC)/Core/FileSystems/FileSystem.cpp \
  $(SRC)/Core/FileSystems/MetaFileSystem.cpp \
  $(SRC)/Core/FileSystems/DirectoryFileSystem.cpp \
  $(SRC)/Core/FileSystems/VirtualDiscFileSystem.cpp \
  $(SRC)/Core/FileSystems/tlzrc.cpp \
  $(SRC)/Core/MIPS/JitCommon/JitCommon.cpp \
  $(SRC)/Core/MIPS/JitCommon/JitBlockCache.cpp \
  $(SRC)/Core/MIPS/JitCommon/JitState.cpp \
  $(SRC)/Core/Util/AudioFormat.cpp \
  $(SRC)/Core/Util/GameManager.cpp \
  $(SRC)/Core/Util/BlockAllocator.cpp \
  $(SRC)/Core/Util/ppge_atlas.cpp \
  $(SRC)/Core/Util/PPGeDraw.cpp \
  $(SRC)/git-version.cpp

LOCAL_MODULE := ppsspp_core
LOCAL_SRC_FILES := $(EXEC_AND_LIB_FILES)

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/Locals.mk
LOCAL_STATIC_LIBRARIES += ppsspp_core

# These are the files just for ppsspp_jni
LOCAL_MODULE := ppsspp_jni
LOCAL_SRC_FILES := \
  $(SRC)/native/android/app-android.cpp \
  $(SRC)/UI/BackgroundAudio.cpp \
  $(SRC)/UI/DevScreens.cpp \
  $(SRC)/UI/EmuScreen.cpp \
  $(SRC)/UI/MainScreen.cpp \
  $(SRC)/UI/MiscScreens.cpp \
  $(SRC)/UI/ReportScreen.cpp \
  $(SRC)/UI/PauseScreen.cpp \
  $(SRC)/UI/SavedataScreen.cpp \
  $(SRC)/UI/Store.cpp \
  $(SRC)/UI/GamepadEmu.cpp \
  $(SRC)/UI/GameInfoCache.cpp \
  $(SRC)/UI/GameScreen.cpp \
  $(SRC)/UI/ControlMappingScreen.cpp \
  $(SRC)/UI/GameSettingsScreen.cpp \
  $(SRC)/UI/TiltAnalogSettingsScreen.cpp \
  $(SRC)/UI/TiltEventProcessor.cpp \
  $(SRC)/UI/TouchControlLayoutScreen.cpp \
  $(SRC)/UI/TouchControlVisibilityScreen.cpp \
  $(SRC)/UI/CwCheatScreen.cpp \
  $(SRC)/UI/InstallZipScreen.cpp \
  $(SRC)/UI/NativeApp.cpp

ifneq ($(SKIPAPP),1)
  include $(BUILD_SHARED_LIBRARY)
endif


ifeq ($(HEADLESS),1)
  include $(CLEAR_VARS)
  include $(LOCAL_PATH)/Locals.mk
  LOCAL_STATIC_LIBRARIES += ppsspp_core

  # Android 5.0 requires PIE for executables.  Only supported on 4.1+, but this is testing anyway.
  LOCAL_CFLAGS += -fPIE
  LOCAL_LDFLAGS += -fPIE -pie

  LOCAL_MODULE := ppsspp_headless
  LOCAL_SRC_FILES := \
    $(SRC)/headless/Headless.cpp \
    $(SRC)/headless/Compare.cpp

  include $(BUILD_EXECUTABLE)
endif

ifeq ($(UNITTEST),1)
  include $(CLEAR_VARS)
  include $(LOCAL_PATH)/Locals.mk
  LOCAL_STATIC_LIBRARIES += ppsspp_core

  # Android 5.0 requires PIE for executables.  Only supported on 4.1+, but this is testing anyway.
  LOCAL_CFLAGS += -fPIE
  LOCAL_LDFLAGS += -fPIE -pie

  LOCAL_C_INCLUDES := $(LOCAL_PATH)/$(SRC)/ext/armips $(LOCAL_C_INCLUDES)

  LIBARMIPS_FILES := \
	$(SRC)/ext/armips/Archs/ARM/Arm.cpp \
	$(SRC)/ext/armips/Archs/ARM/ArmOpcodes.cpp \
	$(SRC)/ext/armips/Archs/ARM/ArmRelocator.cpp \
	$(SRC)/ext/armips/Archs/ARM/CArmInstruction.cpp \
	$(SRC)/ext/armips/Archs/ARM/CThumbInstruction.cpp \
	$(SRC)/ext/armips/Archs/ARM/Pool.cpp \
	$(SRC)/ext/armips/Archs/ARM/ThumbOpcodes.cpp \
	$(SRC)/ext/armips/Archs/MIPS/CMipsInstruction.cpp \
	$(SRC)/ext/armips/Archs/MIPS/CMipsMacro.cpp \
	$(SRC)/ext/armips/Archs/MIPS/Mips.cpp \
	$(SRC)/ext/armips/Archs/MIPS/MipsElfFile.cpp \
	$(SRC)/ext/armips/Archs/MIPS/MipsMacros.cpp \
	$(SRC)/ext/armips/Archs/MIPS/MipsOpcodes.cpp \
	$(SRC)/ext/armips/Archs/MIPS/MipsPSP.cpp \
	$(SRC)/ext/armips/Archs/MIPS/PsxRelocator.cpp \
	$(SRC)/ext/armips/Archs/Z80/CZ80Instruction.cpp \
	$(SRC)/ext/armips/Archs/Z80/z80.cpp \
	$(SRC)/ext/armips/Archs/Z80/z80Opcodes.cpp \
	$(SRC)/ext/armips/Archs/Architecture.cpp \
	$(SRC)/ext/armips/Commands/CAssemblerCommand.cpp \
	$(SRC)/ext/armips/Commands/CAssemblerLabel.cpp \
	$(SRC)/ext/armips/Commands/CDirectiveArea.cpp \
	$(SRC)/ext/armips/Commands/CDirectiveConditional.cpp \
	$(SRC)/ext/armips/Commands/CDirectiveData.cpp \
	$(SRC)/ext/armips/Commands/CDirectiveFile.cpp \
	$(SRC)/ext/armips/Commands/CDirectiveFill.cpp \
	$(SRC)/ext/armips/Commands/CDirectiveMessage.cpp \
	$(SRC)/ext/armips/Core/ELF/ElfFile.cpp \
	$(SRC)/ext/armips/Core/ELF/ElfRelocator.cpp \
	$(SRC)/ext/armips/Core/Assembler.cpp \
	$(SRC)/ext/armips/Core/CMacro.cpp \
	$(SRC)/ext/armips/Core/Common.cpp \
	$(SRC)/ext/armips/Core/Directives.cpp \
	$(SRC)/ext/armips/Core/FileManager.cpp \
	$(SRC)/ext/armips/Core/MathParser.cpp \
	$(SRC)/ext/armips/Core/Misc.cpp \
	$(SRC)/ext/armips/Core/SymbolData.cpp \
	$(SRC)/ext/armips/Core/SymbolTable.cpp \
	$(SRC)/ext/armips/Util/ByteArray.cpp \
	$(SRC)/ext/armips/Util/CommonClasses.cpp \
	$(SRC)/ext/armips/Util/CRC.cpp \
	$(SRC)/ext/armips/Util/EncodingTable.cpp \
	$(SRC)/ext/armips/Util/FileClasses.cpp \
	$(SRC)/ext/armips/Util/StringFormat.cpp \
	$(SRC)/ext/armips/Util/Util.cpp

  ifeq ($(findstring arm64-v8a,$(TARGET_ARCH_ABI)),arm64-v8a)
    TESTARMEMITTER_FILE = $(SRC)/UnitTest/TestArm64Emitter.cpp
  else
    TESTARMEMITTER_FILE = $(SRC)/UnitTest/TestArmEmitter.cpp
  endif

  LOCAL_MODULE := ppsspp_unittest
  LOCAL_SRC_FILES := \
    $(LIBARMIPS_FILES) \
    $(SRC)/Core/MIPS/MIPSAsm.cpp \
    $(SRC)/UnitTest/JitHarness.cpp \
    $(SRC)/UnitTest/TestVertexJit.cpp \
    $(TESTARMEMITTER_FILE) \
    $(SRC)/UnitTest/UnitTest.cpp

  include $(BUILD_EXECUTABLE)
endif

$(call import-module,libzip)
$(call import-module,native)

ifeq ($(ANDROID_NDK_PROFILER),1)
  $(call import-module,android-ndk-profiler)
endif

jni/$(SRC)/git-version.cpp:
	-./git-version-gen.sh
	-..\Windows\git-version-gen.cmd

.PHONY: jni/$(SRC)/git-version.cpp
