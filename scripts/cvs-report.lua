wrk.scheme = "http"
wrk.host = "localhost"
wrk.port = 4001
wrk.method = "GET"
 
done = function(summary, latency, requests)
 
        filename = "results.csv"
        title = os.getenv("TESTEE")
        file = assert(io.open(filename, "a"))
        file.write(
            file,
            string.format(
                "%s,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%d,%d,%d,%d\n",
                title,
                latency.min / 1000,
                latency:percentile(50) / 1000,
                latency:percentile(75) / 1000,
                latency:percentile(90) / 1000,
                latency:percentile(99) / 1000,
                latency:percentile(99.9) / 1000,
                latency.max / 1000,
                latency.mean / 1000,
                summary.duration / 1000000,
                summary.requests,
                summary.errors.status,
                summary.errors.read,
                summary.errors.timeout
                ));
        file.close()

end
