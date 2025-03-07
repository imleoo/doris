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

# add_subdirectory(bufferpool)

# where to put generated libraries
set(LIBRARY_OUTPUT_PATH "${BUILD_DIR}/src/runtime")

# where to put generated binaries
set(EXECUTABLE_OUTPUT_PATH "${BUILD_DIR}/src/runtime")

set(RUNTIME_FILES
    broker_mgr.cpp
    buffer_control_block.cpp
    client_cache.cpp
    descriptors.cpp
    exec_env.cpp
    exec_env_init.cpp
    user_function_cache.cpp
    plan_fragment_executor.cpp
    primitive_type.cpp
    result_buffer_mgr.cpp
    result_writer.cpp    
    runtime_state.cpp
    runtime_filter_mgr.cpp
    runtime_predicate.cpp
    jsonb_value.cpp
    thread_context.cpp
    threadlocal.cc
    decimalv2_value.cpp
    large_int_value.cpp
    struct_value.cpp
    collection_value.cpp
    map_value.cpp
    fragment_mgr.cpp
    load_path_mgr.cpp
    types.cpp
    load_channel_mgr.cpp
    load_channel.cpp
    tablets_channel.cpp
    snapshot_loader.cpp
    query_statistics.cpp 
    message_body_sink.cpp
    stream_load/stream_load_context.cpp
    stream_load/stream_load_executor.cpp
    stream_load/stream_load_recorder.cpp
    stream_load/new_load_stream_mgr.cpp
    routine_load/data_consumer.cpp
    routine_load/data_consumer_group.cpp
    routine_load/data_consumer_pool.cpp
    routine_load/routine_load_task_executor.cpp
    small_file_mgr.cpp
    record_batch_queue.cpp
    result_queue_mgr.cpp
    external_scan_context_mgr.cpp
    memory/system_allocator.cpp
    memory/chunk_allocator.cpp
    memory/mem_tracker_limiter.cpp
    memory/mem_tracker.cpp
    memory/thread_mem_tracker_mgr.cpp
    fold_constant_executor.cpp
    cache/result_node.cpp
    cache/result_cache.cpp
    block_spill_manager.cpp
    task_group/task_group.cpp
    task_group/task_group_manager.cpp
)

if (USE_JEMALLOC AND USE_MEM_TRACKER)
    set(RUNTIME_FILES ${RUNTIME_FILES}
        memory/jemalloc_hook.cpp
        )
endif()

add_library(Runtime STATIC
    ${RUNTIME_FILES}
)

pch_reuse(Runtime)
