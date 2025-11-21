cmake_minimum_required(VERSION 3.16)
project(neutralino-runtime)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Ensure .bin folder exists
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

#
# ============================
#      COMMON SOURCE FILES
# ============================
#
set(SOURCES_COMMON
    # Core
    main.cpp
    settings.cpp
    resources.cpp
    chrome.cpp
    errors.cpp
    helpers.cpp
    extensions_loader.cpp

    # Auth
    auth/authbasic.cpp
    auth/permission.cpp

    # Server
    server/router.cpp
    server/neuserver.cpp

    # API
    api/app/app.cpp
    api/clipboard/clipboard.cpp
    api/computer/computer.cpp
    api/custom/custom.cpp
    api/debug/debug.cpp
    api/events/events.cpp
    api/extensions/extensions.cpp
    api/fs/fs.cpp
    api/os/os.cpp
    api/res/res.cpp
    api/server/server.cpp
    api/storage/storage.cpp
    api/window/window.cpp

    # TinyProcess/Easylogging
    lib/tinyprocess/process.cpp
    lib/easylogging/easylogging++.cc
    lib/platformfolders/platform_folders.cpp

    # clip (common)
    lib/clip/clip.cpp
    lib/clip/image.cpp

    #
    # ====== infoware ======
    #
    lib/infoware/src/version.cpp

    # detail
    lib/infoware/src/detail/winstring_non_windows.cpp
    lib/infoware/src/detail/winstring_windows.cpp
    lib/infoware/src/detail/sysctl_non_darwin.cpp
    lib/infoware/src/detail/sysctl_darwin.cpp

    # CPU
    lib/infoware/src/cpu/architecture/architecture_non_windows.cpp
    lib/infoware/src/cpu/architecture/architecture_windows.cpp

    lib/infoware/src/cpu/frequency/frequency_darwin.cpp
    lib/infoware/src/cpu/frequency/frequency_non_windows_non_darwin.cpp
    lib/infoware/src/cpu/frequency/frequency_windows.cpp

    lib/infoware/src/cpu/quantities_cache/quantities_cache_non_windows_non_darwin.cpp
    lib/infoware/src/cpu/quantities_cache/quantities_cache_darwin.cpp
    lib/infoware/src/cpu/quantities_cache/quantities_cache_windows.cpp

    lib/infoware/src/cpu/vendor_model_name/vendor_model_name_darwin.cpp
    lib/infoware/src/cpu/vendor_model_name/vendor_model_name_non_windows_non_darwin.cpp
    lib/infoware/src/cpu/vendor_model_name/vendor_model_name_windows.cpp

    # GPU
    lib/infoware/src/gpu/blank_all.cpp
    lib/infoware/src/gpu/d3d.cpp
    lib/infoware/src/gpu/OpenCL.cpp
    lib/infoware/src/gpu/OpenGL.cpp

    # System
    lib/infoware/src/system/amounts/amounts_non_windows.cpp
    lib/infoware/src/system/amounts/amounts_windows.cpp

    lib/infoware/src/system/displays/displays_darwin.cpp
    lib/infoware/src/system/displays/displays_default_blank.cpp
    lib/infoware/src/system/displays/displays_windows.cpp
    lib/infoware/src/system/displays/displays_x11.cpp

    lib/infoware/src/system/kernel_info/kernel_info_non_windows.cpp
    lib/infoware/src/system/kernel_info/kernel_info_windows.cpp

    lib/infoware/src/system/memory/memory_darwin.cpp
    lib/infoware/src/system/memory/memory_non_windows_non_darwin.cpp
    lib/infoware/src/system/memory/memory_windows.cpp

    lib/infoware/src/system/OS_info/os_info_darwin.cpp
    lib/infoware/src/system/OS_info/os_info_non_windows_non_darwin.cpp
    lib/infoware/src/system/OS_info/os_info_windows.cpp

    #
    # ====== efsw (common) ======
    #
    lib/efsw/src/efsw/DirectorySnapshot.cpp
    lib/efsw/src/efsw/DirectorySnapshotDiff.cpp
    lib/efsw/src/efsw/DirWatcherGeneric.cpp
    lib/efsw/src/efsw/EfswDebug.cpp
    lib/efsw/src/efsw/EfswFileSystem.cpp
    lib/efsw/src/efsw/FileInfo.cpp
    lib/efsw/src/efsw/FileWatcher.cpp
    lib/efsw/src/efsw/FileWatcherCWrapper.cpp
    lib/efsw/src/efsw/FileWatcherFSEvents.cpp
    lib/efsw/src/efsw/FileWatcherGeneric.cpp
    lib/efsw/src/efsw/FileWatcherImpl.cpp
    lib/efsw/src/efsw/FileWatcherInotify.cpp
    lib/efsw/src/efsw/FileWatcherKqueue.cpp
    lib/efsw/src/efsw/FileWatcherWin32.cpp
    lib/efsw/src/efsw/Log.cpp
    lib/efsw/src/efsw/Mutex.cpp
    lib/efsw/src/efsw/String.cpp
    lib/efsw/src/efsw/System.cpp
    lib/efsw/src/efsw/Thread.cpp
    lib/efsw/src/efsw/Watcher.cpp
    lib/efsw/src/efsw/WatcherFSEvents.cpp
    lib/efsw/src/efsw/WatcherGeneric.cpp
    lib/efsw/src/efsw/WatcherInotify.cpp
    lib/efsw/src/efsw/WatcherKqueue.cpp
    lib/efsw/src/efsw/WatcherWin32.cpp
)

#
# ============================
#       PLATFORM FILES
# ============================
#
set(SOURCES_LINUX
    lib/tinyprocess/process_unix.cpp
    lib/clip/clip_x11.cpp

    lib/efsw/src/efsw/platform/posix/ThreadImpl.cpp
    lib/efsw/src/efsw/platform/posix/MutexImpl.cpp
    lib/efsw/src/efsw/platform/posix/FileSystemImpl.cpp
    lib/efsw/src/efsw/platform/posix/SystemImpl.cpp
)

set(SOURCES_WINDOWS
    lib/tinyprocess/process_win.cpp
    lib/clip/clip_win.cpp

    lib/efsw/src/efsw/platform/win/FileSystemImpl.cpp
    lib/efsw/src/efsw/platform/win/MutexImpl.cpp
    lib/efsw/src/efsw/platform/win/SystemImpl.cpp
    lib/efsw/src/efsw/platform/win/ThreadImpl.cpp

    lib/postject/windows_dummy.res
)

#
# ============================
#            LINUX
# ============================
#
if(UNIX AND NOT APPLE)
    message(STATUS "Configuring Neutralino runtime for Linux")

    include_directories(
        .
        lib
        lib/asio/include
        lib/infoware/include
        lib/efsw/include
        lib/efsw/src
    )

    find_package(PkgConfig REQUIRED)
    pkg_check_modules(GTK REQUIRED gtk+-3.0)
    pkg_check_modules(GLIB REQUIRED glib-2.0)
    pkg_check_modules(X11 REQUIRED x11)
    pkg_check_modules(XRANDR REQUIRED xrandr)
    pkg_check_modules(XCB REQUIRED xcb)

    add_executable(neutralino-linux_x64
        ${SOURCES_COMMON}
        ${SOURCES_LINUX}
    )

    target_compile_definitions(neutralino-linux_x64 PRIVATE
        NEU_VERSION="6.3.0"
        NEU_COMMIT="ed0f2bef2941fbb4c410f24ffda863f23bd89c46"
        ELPP_NO_DEFAULT_LOG_FILE=1
        ASIO_STANDALONE
        INFOWARE_VERSION="0.6.0"
        INFOWARE_USE_X11
        CLIP_ENABLE_IMAGE
        HAVE_XCB_XLIB_H
        WEBVIEW_GTK=1
        TRAY_APPINDICATOR=1
        HAVE_PNG_H
    )

    target_link_libraries(neutralino-linux_x64
        ${GTK_LIBRARIES}
        ${GLIB_LIBRARIES}
        ${X11_LIBRARIES}
        ${XRANDR_LIBRARIES}
        ${XCB_LIBRARIES}
        png
        stdc++fs
        dl
        pthread
    )

    set_target_properties(neutralino-linux_x64 PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin
    )

#
# ============================
#           WINDOWS
# ============================
#
elseif(WIN32)
    message(STATUS "Configuring Neutralino runtime for Windows")

    include_directories(
        .
        lib
        lib/asio/include
        lib/infoware/include
        lib/efsw/include
        lib/efsw/src
        lib/webview/windows
    )

    add_executable(neutralino-win_x64
        ${SOURCES_COMMON}
        ${SOURCES_WINDOWS}
    )

    target_compile_definitions(neutralino-win_x64 PRIVATE
        NEU_VERSION="6.3.0"
        NEU_COMMIT="ed0f2bef2941fbb4c410f24ffda863f23bd89c46"
        ELPP_NO_DEFAULT_LOG_FILE=1
        ASIO_STANDALONE
        INFOWARE_VERSION="0.6.0"
        INFOWARE_USE_X11
        CLIP_ENABLE_IMAGE
        _WEBSOCKETPP_CPP11_STL_
        _HAS_STD_BYTE=0
        TRAY_WINAPI=1
        UNICODE
        _UNICODE
    )

    target_link_libraries(neutralino-win_x64
        ${CMAKE_SOURCE_DIR}/lib/webview/windows/WebView2LoaderStatic.lib
        gdi32
        version
        Ole32
        OleAut32
        wbemuuid
        ntdll
        dwmapi
    )

    # Neutralino → GUI app with wWinMain
    set_property(TARGET neutralino-win_x64 PROPERTY WIN32_EXECUTABLE TRUE)
    set_property(TARGET neutralino-win_x64 PROPERTY LINK_FLAGS "/SUBSYSTEM:WINDOWS")

    set_target_properties(neutralino-win_x64 PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin
        OUTPUT_NAME "neutralino-win_x64"
    )

else()
    message(FATAL_ERROR "Unsupported platform.")
endif()
