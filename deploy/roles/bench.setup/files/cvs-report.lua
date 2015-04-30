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
                "%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%d,%d\n",
                latency.min / 1000,
                latency:percentile(50) / 1000,
                latency:percentile(75) / 1000,
                latency:percentile(90) / 1000,
                latency:percentile(99) / 1000,
                latency:percentile(99.9) / 1000,
                latency.max / 1000,
                summary.duration / 1000,
                summary.requests,
                summary.errors.status));
        file.close()

end
