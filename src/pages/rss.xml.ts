import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import { marked } from 'marked';
import type { APIContext } from 'astro';

export async function GET(context: APIContext) {
  const posts = await getCollection('blog');
  const sorted = posts.sort((a, b) => b.data.pubDate.valueOf() - a.data.pubDate.valueOf());

  return rss({
    title: "Pasha Fateev's Blog",
    description: 'Field notes on software engineering, automation, and developer workflows.',
    site: context.site!,
    items: sorted.map((post) => ({
      title: post.data.title,
      description: post.data.description,
      pubDate: post.data.pubDate,
      link: `/blog/${post.slug}`,
      content: marked.parse(post.body) as string,
    })),
    customData: '<language>en-us</language>',
  });
}
