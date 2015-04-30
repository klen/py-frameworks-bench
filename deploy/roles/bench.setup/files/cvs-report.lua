wrk.scheme = "http"
wrk.host = "localhost"
wrk.port = 4001
wrk.method = "GET"
 
done = function(summary, latency, requests)
 
        filename = "stats.cvs"
        file = assert(io.open(filename, "a"))
        file.write(
            file,
            string.format(
                "%.2f,%.2f,%.2f,%.2f,%d\n",
                latency:percentile(50) / 1000, latency:percentile(75) / 1000, latency:percentile(90) / 1000, summary.requests / 10, summary.errors.status));
        file.close()

end
