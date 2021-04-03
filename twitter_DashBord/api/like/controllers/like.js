//'use strict';

/**
 * Read the documentation (https://strapi.io/documentation/developer-docs/latest/development/backend-customization.html#core-controllers)
 * to customize this controller
 */

//module.exports = {};

'use strict';
const {parseMultipartData, sanitizeEntity} = require('strapi-utils')
/**
 * Read the documentation (https://strapi.io/documentation/v3.x/concepts/controllers.html#core-controllers)
 * to customize this controller
 */

module.exports = {
    async create(ctx){
        let entity

        const {user} = ctx.state //Logged in User
        const {tweet} = ctx.request.body //Id of tweet


        const realtweet = await strapi.services.tweet.findOne({
            id: tweet
        })
        if(!realtweet){
            ctx.throw(400, "This tweet doesn't exist")
        }

        const found = await strapi.services.like.findOne({
            user: user.id,
            tweet
        })
        if(found){
            ctx.throw(420, "You already liked this tweet")
        }

        if(ctx.is('multipart')){
            ctx.throw(400, "Only make JSON requests")
        } else {
            entity = await strapi.services.like.create({tweet, user})
        }

        //Update the likes counter
        const {likes} = realtweet
        const updatedtweet = await strapi.services.tweet.update({
            id: tweet
        }, {
            likes: likes + 1
        })

        return sanitizeEntity(entity, {model: strapi.models.like})
    },

    async delete(ctx){
        const {user} = ctx.state
        const {tweetId} = ctx.params

        const tweet = tweetId

  

        const entity = await strapi.services.like.delete({
            tweet,
            user: user.id
        })

        if(entity.length){
            const {likes} = entity[0].tweet
            const updatedtweet = await strapi.services.tweet.update({
                id: tweet
            }, {
                likes: likes - 1
            })

            return sanitizeEntity(entity[0], {model: strapi.models.like})
        }
    }
};
