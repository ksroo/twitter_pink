const { parseMultipartData, sanitizeEntity } = require('strapi-utils');

module.exports = {

  async comment(ctx) {
    let entity;
    if (ctx.is('multipart')) {
      const { data, files } = parseMultipartData(ctx);
      entity = await strapi.services.comment.create(data, { files });
    } else {
     ctx.request.body.user = ctx.state.user.id;
     ctx.request.body.tweet=ctx.params.id;
      entity = await strapi.services.comment.create(ctx.request.body);
    }
    return sanitizeEntity(entity, { model: strapi.models.comment });
  },


};
