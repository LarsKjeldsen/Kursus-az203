using System.Net;

public static async Task<HttpResponseMessage> Run(HttpRequestMessage req, TraceWriter log)
{
    log.Info("C# HTTP trigger function processed a request.");

    // Get request body
    dynamic data = await req.Content.ReadAsAsync<object>();

    string gitHubIssueTitle = data?.issue?.title;

    log.Info($"New issue title: {gitHubIssueTitle}");

    return req.CreateResponse(HttpStatusCode.OK, "From Github issue:" + gitHubIssueTitle);
}