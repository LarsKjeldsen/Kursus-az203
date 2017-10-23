public class GreetingRequest
{
    public string Number;
    public string Message;

    public override string ToString() => $"{Number} {Message}";
}