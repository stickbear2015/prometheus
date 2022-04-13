url = "http://www.blazingstarradio.com/prometheus/"
async = require("async")
data = async.doAsyncRemoteRequest(url, dataProcesser, "http", 120)

function dataProcesser(retval, page, status, headers, full_status, requested_url, request_body)
if status == 200 then
-- page grabbed.
Note(page)
end -- If.
end -- Function.