cmake_minimum_required(VERSION 3.10)
project(mp3lame C)

set(LAME_DIR ${CMAKE_CURRENT_SOURCE_DIR}/lame_3.99.5_libmp3lame)

add_library(mp3lame SHARED
    ${LAME_DIR}/bitstream.c
    ${LAME_DIR}/encoder.c
    ${LAME_DIR}/fft.c
    ${LAME_DIR}/gain_analysis.c
    ${LAME_DIR}/id3tag.c
    ${LAME_DIR}/lame.c
    ${LAME_DIR}/mpglib_interface.c
    ${LAME_DIR}/newmdct.c
    ${LAME_DIR}/presets.c
    ${LAME_DIR}/psymodel.c
    ${LAME_DIR}/quantize.c
    ${LAME_DIR}/quantize_pvt.c
    ${LAME_DIR}/reservoir.c
    ${LAME_DIR}/set_get.c
    ${LAME_DIR}/tables.c
    ${LAME_DIR}/takehiro.c
    ${LAME_DIR}/util.c
    ${LAME_DIR}/vbrquantize.c
    ${LAME_DIR}/VbrTag.c
    ${LAME_DIR}/version.c
    lame_util.c
)

target_include_directories(mp3lame PRIVATE ${LAME_DIR})

target_compile_definitions(mp3lame PRIVATE STDC_HEADERS)

# 16KB page size alignment for Android 15+
target_link_options(mp3lame PRIVATE "-Wl,-z,max-page-size=16384")
