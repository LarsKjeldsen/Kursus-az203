module.exports = function (context, req) {
    context.log("requesting customers");
    context.res = {
        status: 200,
        body: [
            { name: "Ben" }, 
            { name: "Lily"},
            { name: "Joel"},
            { name: "Sam"},
            { name: "Annie"}]
    };
    context.done();
};