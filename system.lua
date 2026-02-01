local system = {}
system.omit = function() rl.SetTraceLogLevel(rl.LOG_NONE) end

function system.init()
    if not __RAYLIB_BARF then system.omit() end
    log.trace('[System] initialized.')
end

function system.close()
    log.trace('[System] closed.')
end

-- bool FileExists(const char *fileName);
-- Check if file exists
---@type function raylib function
system.file_exists = rl.FileExists

-- bool DirectoryExists(const char *dirPath);
-- Check if a directory path exists
---@type function raylib function
system.directory_exists = rl.DirectoryExists

-- bool IsFileExtension(const char *fileName, const char *ext);
-- Check file extension (including point: .png, .wav)
---@type function raylib function
system.is_file_extension = rl.IsFileExtension

-- int GetFileLength(const char *fileName);
-- Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
---@type function raylib function
system.get_file_length = rl.GetFileLength

-- const char *GetFileExtension(const char *fileName);
-- Get pointer to extension for a filename string (includes dot: '.png')
---@type function raylib function
system.get_file_extension = rl.GetFileExtension

-- const char *GetFileName(const char *filePath);
-- Get pointer to filename for a path string
---@type function raylib function
system.get_file_name = rl.GetFileName

-- const char *GetFileNameWithoutExt(const char *filePath);
-- Get filename string without extension (uses static string)
---@type function raylib function
system.get_file_name_without_ext = rl.GetFileNameWithoutExt

-- const char *GetDirectoryPath(const char *filePath);
-- Get full path for a given fileName with path (uses static string)
---@type function raylib function
system.get_directory_path = rl.GetDirectoryPath

-- const char *GetPrevDirectoryPath(const char *dirPath);
-- Get previous directory path for a given path (uses static string)
---@type function raylib function
system.get_prev_directory_path = rl.GetPrevDirectoryPath

-- const char *GetWorkingDirectory(void);
-- Get current working directory (uses static string)
---@type function raylib function
system.get_working_directory = rl.GetWorkingDirectory

-- const char *GetApplicationDirectory(void);
-- Get the directory of the running application (uses static string)
---@type function raylib function
system.get_application_directory = rl.GetApplicationDirectory

-- int MakeDirectory(const char *dirPath);
-- Create directories (including full path requested), returns 0 on success
---@type function raylib function
-- system.make_directory = rl.MakeDirectory

-- bool ChangeDirectory(const char *dir);
-- Change working directory, return true on success
---@type function raylib function
-- system.change_directory = rl.ChangeDirectory

-- bool IsPathFile(const char *path);
-- Check if a given path is a file or a directory
---@type function raylib function
system.is_path_file = rl.IsPathFile

-- bool IsFileNameValid(const char *fileName);
-- Check if fileName is valid for the platform/OS
---@type function raylib function
-- system.is_file_name_valid = rl.IsFileNameValid

-- FilePathList LoadDirectoryFiles(const char *dirPath);
-- Load directory filepaths
---@type function raylib function
system.load_directory_files = rl.LoadDirectoryFiles

-- FilePathList LoadDirectoryFilesEx(const char *basePath, const char *filter, bool scanSubdirs);
--  Load directory filepaths with extension filtering and recursive directory scan. U
---@type function raylib function
system.load_directory_files_ex = rl.LoadDirectoryFilesEx

-- void UnloadDirectoryFiles(FilePathList files);
-- Unload filepaths
---@type function raylib function
system.unload_directory_files = rl.UnloadDirectoryFiles

-- bool IsFileDropped(void);
-- Check if a file has been dropped into window 
---@type function raylib function
system.is_file_dropped = rl.IsFileDropped

-- FilePathList LoadDroppedFiles(void);
-- Load dropped filepaths
---@type function raylib function
system.load_dropped_files = rl.LoadDroppedFiles

-- void UnloadDroppedFiles(FilePathList files);
-- Unload dropped filepaths
---@type function raylib function
system.unload_dropped_files = rl.UnloadDroppedFiles

-- long GetFileModTime(const char *fileName);   
---@type function raylib function
system.get_file_mod_time = rl.GetFileModTime
return system
