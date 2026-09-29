extends Node

var use_sub_threads: bool = true
var _active_load_requests: Dictionary = {}

func _process(_delta: float) -> void:
	if _active_load_requests.is_empty():
		return

	var completed_resource_paths: Array[String] = []

	for resource_path: String in _active_load_requests.keys():
		var progress_status_array: Array = []
		var current_load_status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(resource_path, progress_status_array)

		match current_load_status:
			ResourceLoader.THREAD_LOAD_IN_PROGRESS:
				@warning_ignore("unsafe_cast")
				var progress_percentage: float = progress_status_array[0] as float if progress_status_array else 0.0
				for callback_function: Callable in _active_load_requests[resource_path].progress_callbacks:
					if callback_function.is_valid():
						callback_function.call(progress_percentage)

			ResourceLoader.THREAD_LOAD_LOADED:
				var final_resource: Resource = ResourceLoader.load_threaded_get(resource_path)
				for callback_function: Callable in _active_load_requests[resource_path].completion_callbacks:
					if callback_function.is_valid():
						callback_function.call(final_resource)
				completed_resource_paths.append(resource_path)

			ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
				printerr('ThreadedLoader: Failed to load: ', resource_path)
				for callback_function: Callable in _active_load_requests[resource_path].completion_callbacks:
					if callback_function.is_valid():
						callback_function.call(null)
				completed_resource_paths.append(resource_path)
	
	for resource_path: String in completed_resource_paths:
		@warning_ignore("return_value_discarded")
		_active_load_requests.erase(resource_path)

func load_async(resource_path: String, on_load_finished: Callable, on_progress_updated: Callable = Callable()) -> void:
	if ResourceLoader.has_cached(resource_path):
		on_load_finished.call(ResourceLoader.load(resource_path))
		return

	if not _active_load_requests.has(resource_path):
		var error_code: Error = ResourceLoader.load_threaded_request(resource_path, "", use_sub_threads)
		if error_code != OK:
			printerr("ThreadedLoader: Thread request error for: ", resource_path)
			on_load_finished.call(null)
			return
		_active_load_requests[resource_path] = {"completion_callbacks": [], "progress_callbacks": []}
	
	@warning_ignore("unsafe_method_access")
	_active_load_requests[resource_path].completion_callbacks.append(on_load_finished)
	if on_progress_updated.is_valid():
		@warning_ignore("unsafe_method_access")
		_active_load_requests[resource_path].progress_callbacks.append(on_progress_updated)
