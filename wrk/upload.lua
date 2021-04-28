function read_txt_file(path)
    local file, errorMessage = io.open(path, "r")
    if not file then 
        error("Could not read the file:" .. errorMessage .. "\n")
    end

    local content = file:read "*all"
    file:close()
    return content
end

local Boundary = "----WebKitFormBoundaryePkpFF7tjBAqx29L"
local BodyBoundary = "--" .. Boundary
local LastBoundary = "--" .. Boundary .. "--"
local CRLF = "\r\n"
local ContentDisposition = "Content-Disposition: form-data; name=\"file\"; filename=\"test.txt\""
local FileBody = read_txt_file("/scripts/1kb.txt")

wrk.method = "POST"
wrk.headers["content-type"] = "multipart/form-data; boundary=" .. Boundary
wrk.body = BodyBoundary .. CRLF .. ContentDisposition .. CRLF .. CRLF .. FileBody .. CRLF .. LastBoundary

-- Save report

framework = os.getenv("FRAMEWORK")
filename = os.getenv("FILENAME")

done = function(summary, latency, requests)
    file = assert(io.open(filename, "a"))
    file.write(
        file,
        string.format(
            "%s,%d,%.2f,%.2f,%.2f,%.2f,%d,%d,%d\n",
            framework,
            summary.requests,
            latency:percentile(50) / 1000,
            latency:percentile(75) / 1000,
            latency:percentile(90) / 1000,
            latency.mean / 1000,
            summary.errors.status,
            summary.errors.read,
            summary.errors.timeout
            ));
    file.close()
end
