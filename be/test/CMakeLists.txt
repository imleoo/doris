# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# where to put generated libraries
set(LIBRARY_OUTPUT_PATH "${BUILD_DIR}/test")

# where to put generated libraries
set(EXECUTABLE_OUTPUT_PATH "${BUILD_DIR}/test")

set(AGENT_TEST_FILES
    agent/utils_test.cpp
    # agent/agent_server_test.cpp
    # agent/heartbeat_server_test.cpp
)
set(COMMON_TEST_FILES
    common/resource_tls_test.cpp
    common/status_test.cpp
    common/config_test.cpp
    common/exception_test.cpp
)

set(EXEC_TEST_FILES
    vec/exec/parquet/parquet_thrift_test.cpp
    vec/exec/parquet/parquet_reader_test.cpp
)

if(DEFINED DORIS_WITH_LZO)
    set(EXEC_TEST_FILES ${EXEC_FILES} exec/plain_text_line_reader_lzop_test.cpp)
endif()

set(EXPRS_TEST_FILES
    # exprs/binary_predicate_test.cpp
    # exprs/in_predicate_test.cpp
    # exprs/expr-test.cpp
    # exprs/hybrid_set_test.cpp
    # exprs/in-predicate-test.cpp
    exprs/json_function_test.cpp
    exprs/bloom_filter_predicate_test.cpp
)
set(GEO_TEST_FILES
    geo/wkt_parse_test.cpp
    geo/geo_types_test.cpp
)
set(GUTIL_TEST_FILES
    gutil/strings/numbers_test.cpp
)
set(HTTP_TEST_FILES
    http/message_body_sink_test.cpp
    http/http_utils_test.cpp
    http/http_client_test.cpp
    http/http_auth_test.cpp
    # TODO this will overide HttpChannel and make other test failed
    # http/metrics_action_test.cpp
)
set(IO_TEST_FILES
    io/cache/remote_file_cache_test.cpp
    io/cache/file_block_cache_test.cpp
    io/fs/local_file_system_test.cpp
    io/fs/remote_file_system_test.cpp
    io/fs/buffered_reader_test.cpp
)
set(OLAP_TEST_FILES
    olap/engine_storage_migration_task_test.cpp
    olap/timestamped_version_tracker_test.cpp
    olap/tablet_schema_helper.cpp
    olap/delta_writer_test.cpp
    olap/delete_handler_test.cpp
    olap/lru_cache_test.cpp
    olap/bloom_filter_test.cpp
    olap/itoken_extractor_test.cpp
    olap/file_header_test.cpp
    #olap/file_utils_test.cpp
    olap/cumulative_compaction_policy_test.cpp
    #olap/row_cursor_test.cpp
    olap/skiplist_test.cpp
    olap/memtable_sort_test.cpp
    olap/olap_meta_test.cpp
    olap/decimal12_test.cpp
    olap/storage_types_test.cpp
    #olap/rowset/segment_v2/bitshuffle_page_test.cpp
    #olap/rowset/segment_v2/plain_page_test.cpp
    olap/rowset/segment_v2/bitmap_index_test.cpp
    #olap/rowset/segment_v2/binary_plain_page_test.cpp
    #olap/rowset/segment_v2/binary_prefix_page_test.cpp
    #olap/rowset/segment_v2/column_reader_writer_test.cpp
    olap/rowset/segment_v2/encoding_info_test.cpp
    olap/rowset/segment_v2/ordinal_page_index_test.cpp
    #olap/rowset/segment_v2/rle_page_test.cpp
    #olap/rowset/segment_v2/binary_dict_page_test.cpp
    olap/rowset/segment_v2/row_ranges_test.cpp
    #olap/rowset/segment_v2/frame_of_reference_page_test.cpp
    olap/rowset/segment_v2/block_bloom_filter_test.cpp
    olap/rowset/segment_v2/bloom_filter_index_reader_writer_test.cpp
    olap/rowset/segment_v2/zone_map_index_test.cpp
    olap/rowset/segment_v2/inverted_index_searcher_cache_test.cpp
    olap/tablet_meta_test.cpp
    olap/tablet_meta_manager_test.cpp
    olap/tablet_mgr_test.cpp
    olap/tablet_test.cpp
    olap/rowset/rowset_meta_manager_test.cpp
    olap/rowset/rowset_meta_test.cpp
    olap/rowset/beta_rowset_test.cpp
    olap/rowset/unique_rowset_id_generator_test.cpp
    olap/rowset/rowset_tree_test.cpp
    olap/txn_manager_test.cpp
    olap/key_coder_test.cpp
    olap/short_key_index_test.cpp
    olap/primary_key_index_test.cpp
    olap/page_cache_test.cpp
    olap/hll_test.cpp
    olap/selection_vector_test.cpp
    olap/block_column_predicate_test.cpp
    olap/options_test.cpp
    olap/common_test.cpp
    olap/tablet_cooldown_test.cpp
    olap/rowid_conversion_test.cpp
    olap/remote_rowset_gc_test.cpp
    #olap/segcompaction_test.cpp
    olap/ordered_data_compaction_test.cpp
    olap/delete_bitmap_calculator_test.cpp
)

set(RUNTIME_TEST_FILES
    # runtime/result_buffer_mgr_test.cpp
    # runtime/parallel_executor_test.cpp
    # runtime/dpp_sink_test.cpp
    # runtime/export_task_mgr_test.cpp
    runtime/arena_test.cpp
    runtime/decimalv2_value_test.cpp
    runtime/large_int_value_test.cpp
    runtime/string_value_test.cpp
    runtime/fragment_mgr_test.cpp
    runtime/mem_limit_test.cpp
    runtime/snapshot_loader_test.cpp
    runtime/user_function_cache_test.cpp
    runtime/routine_load_task_executor_test.cpp
    runtime/small_file_mgr_test.cpp
    runtime/heartbeat_flags_test.cpp
    runtime/result_queue_mgr_test.cpp
    runtime/test_env.cc
    runtime/external_scan_context_mgr_test.cpp
    runtime/memory/chunk_allocator_test.cpp
    runtime/memory/system_allocator_test.cpp
    runtime/cache/partition_cache_test.cpp
    #runtime/array_test.cpp
)
set(TESTUTIL_TEST_FILES
    testutil/test_util.cpp
    testutil/desc_tbl_builder.cc
    testutil/function_utils.cpp
    testutil/run_all_tests.cpp
)

set(UTIL_TEST_FILES
    util/bit_util_test.cpp
    util/brpc_client_cache_test.cpp
    util/path_trie_test.cpp
    util/coding_test.cpp
    util/crc32c_test.cpp
    util/lru_cache_util_test.cpp
    util/cidr_test.cpp
    util/metrics_test.cpp
    util/doris_metrics_test.cpp
    util/system_metrics_test.cpp
    util/string_util_test.cpp
    util/string_parser_test.cpp
    util/core_local_test.cpp
    util/byte_buffer2_test.cpp
    util/uid_util_test.cpp
    util/encryption_util_test.cpp
    util/md5_test.cpp
    util/sm3_test.cpp
    util/bitmap_test.cpp
    util/bitmap_value_test.cpp
    util/faststring_test.cpp
    util/rle_encoding_test.cpp
    util/tdigest_test.cpp
    util/block_compression_test.cpp
    util/frame_of_reference_coding_test.cpp
    util/bit_stream_utils_test.cpp
    util/radix_sort_test.cpp
    util/utf8_check_test.cpp
    util/cgroup_util_test.cpp
    util/path_util_test.cpp
    util/parse_util_test.cpp
    util/countdown_latch_test.cpp
    util/scoped_cleanup_test.cpp
    util/thread_test.cpp
    util/threadpool_test.cpp
    util/mysql_row_buffer_test.cpp
    util/easy_json-test.cpp
    util/http_channel_test.cpp
    util/histogram_test.cpp
    util/s3_uri_test.cpp
    util/sort_heap_test.cpp
    util/counts_test.cpp
    util/date_func_test.cpp
    util/quantile_state_test.cpp
    util/interval_tree_test.cpp
    util/key_util_test.cpp
)
if (OS_MACOSX)
    list(REMOVE_ITEM UTIL_TEST_FILES util/system_metrics_test.cpp)
endif()

set(VEC_TEST_FILES
    vec/aggregate_functions/agg_collect_test.cpp
    vec/aggregate_functions/agg_histogram_test.cpp
    vec/aggregate_functions/agg_test.cpp
    vec/aggregate_functions/agg_min_max_test.cpp
    vec/aggregate_functions/agg_replace_test.cpp
    vec/aggregate_functions/vec_window_funnel_test.cpp
    vec/aggregate_functions/vec_retention_test.cpp
    vec/aggregate_functions/vec_sequence_match_test.cpp
    vec/aggregate_functions/agg_min_max_by_test.cpp
    vec/columns/column_decimal_test.cpp
    vec/columns/column_fixed_length_object_test.cpp
    vec/data_types/complex_type_test.cpp
    vec/data_types/serde/data_type_to_string_test.cpp
    vec/data_types/serde/data_type_serde_pb_test.cpp
    vec/data_types/serde/data_type_serde_arrow_test.cpp
    vec/data_types/serde/data_type_serde_mysql_test.cpp
    vec/core/block_test.cpp
    vec/core/block_spill_test.cpp
    vec/core/column_array_test.cpp
    vec/core/column_complex_test.cpp
    vec/core/column_nullable_test.cpp
    vec/core/column_vector_test.cpp
    vec/exec/vgeneric_iterators_test.cpp
    vec/exec/vtablet_sink_test.cpp
    vec/exprs/vexpr_test.cpp
    vec/function/function_array_aggregation_test.cpp
    vec/function/function_array_element_test.cpp
    vec/function/function_array_index_test.cpp
    vec/function/function_array_size_test.cpp
    vec/function/function_arrays_overlap_test.cpp
    vec/function/function_bitmap_test.cpp
    vec/function/function_hash_test.cpp
    vec/function/function_math_test.cpp
    vec/function/function_string_test.cpp
    vec/function/function_time_test.cpp
    vec/function/function_ifnull_test.cpp
    vec/function/function_nullif_test.cpp
    vec/function/function_like_test.cpp
    vec/function/function_arithmetic_test.cpp
    vec/function/function_json_test.cpp
    vec/function/function_jsonb_test.cpp
    vec/function/function_geo_test.cpp
    vec/function/function_test_util.cpp
    vec/function/function_url_test.cpp
    vec/function/table_function_test.cpp
    vec/function/function_running_difference_test.cpp
    vec/runtime/vdata_stream_test.cpp
    vec/runtime/vdatetime_value_test.cpp
    vec/utils/arrow_column_to_doris_column_test.cpp
    vec/utils/histogram_helpers_test.cpp
    vec/olap/char_type_padding_test.cpp
    vec/olap/vertical_compaction_test.cpp
    vec/jsonb/serialize_test.cpp
)
add_executable(doris_be_test
    ${AGENT_TEST_FILES}
    ${COMMON_TEST_FILES}
    ${EXEC_TEST_FILES}
    ${EXPRS_TEST_FILES}
    ${GEO_TEST_FILES}
    ${GUTIL_TEST_FILES}
    ${HTTP_TEST_FILES}
    ${IO_TEST_FILES}
    ${OLAP_TEST_FILES}
    ${RUNTIME_TEST_FILES}
    ${TESTUTIL_TEST_FILES}
    ${UTIL_TEST_FILES}
    ${VEC_TEST_FILES}
)

target_link_libraries(doris_be_test ${TEST_LINK_LIBS})
set_target_properties(doris_be_test PROPERTIES COMPILE_FLAGS "-fno-access-control")

if (OS_MACOSX AND ARCH_ARM)
    find_program(DSYMUTIL NAMES dsymutil)
    message(STATUS "dsymutil found: ${DSYMUTIL}")
    add_custom_command(TARGET doris_be_test POST_BUILD
        COMMAND ${DSYMUTIL} $<TARGET_FILE:doris_be_test>
        COMMAND ${CMAKE_STRIP} -S $<TARGET_FILE:doris_be_test>
    )
endif()

if (BUILD_BENCHMARK_TOOL AND BUILD_BENCHMARK_TOOL STREQUAL "ON")
    add_executable(benchmark_tool
    tools/benchmark_tool.cpp
    testutil/test_util.cpp
    olap/tablet_schema_helper.cpp
    )

    target_link_libraries(benchmark_tool ${TEST_LINK_LIBS})
    set_target_properties(benchmark_tool PROPERTIES COMPILE_FLAGS "-fno-access-control")
endif()
