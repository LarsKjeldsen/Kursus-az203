public class CreateGreetingRequest
{
    public string Number;
    public string FirstName;

    public override string ToString() => $"{FirstName} {Number}";
}