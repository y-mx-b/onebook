enum InitErrors: Error {
    // config errors
    case checkForConfigFileFail
    case createConfigFail
    // bookmark directory errors
    case checkForBookmarkDirectoryFail
    case createBookmarkDirectoryFail

}

