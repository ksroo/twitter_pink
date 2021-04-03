module.exports = async (ctx, next) => {

    // لكي نتاكد ان المستخدم الي بيعمل ليك هو صاحب الحساب
    if(!ctx.request.query["tweet.user"]){
        return ctx.unauthorized("Please specify a tweet.user={id}")
    }

    const targetUser = String(ctx.request.query["tweet.user"])
    const loggedInUser = String(ctx.state.user.id)

    if(targetUser === loggedInUser){
        return next()
    } else {
        return ctx.unauthorized("Target user is different from the logged in user")
    }
}
