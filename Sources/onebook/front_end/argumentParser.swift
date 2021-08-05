import ArgumentParser

struct Onebook: ParsableCommand {
    @Argument var input: String
    @Option var extraInput: String
    @Flag var verbose = false

    mutating func run() throws {
        if verbose {
            print("Parsing input '\(input)'...")
            if extraInput.isEmpty {
                print("Parsing extra input '\(extraInput)'...")
            }
        }
        print("\(input)")
        print("\(extraInput)")
    }
}
