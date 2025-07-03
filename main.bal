import ballerina/ftp;
import ballerina/log;

listener ftp:Listener weatherListener = new (host = host, path = path, auth = {
    credentials: {
        username: username,
        password: password
    }
}, fileNamePattern = pattern);

service ftp:Service on weatherListener {
    remote function onFileChange(ftp:WatchEvent & readonly event, ftp:Caller caller) returns error? {
        do {
            foreach var addFile in event.addedFiles
            {
                log:printInfo("File added:" + addFile.name);
            }
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
