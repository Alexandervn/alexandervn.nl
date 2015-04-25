---
template: post.html
date: 2012-06-14
title: Heading classes, .edit and .mute
slug: heading-classes-edit-mute
---

Heading classes
--

For SEO and accessibility it's a good practice to make sure the hierarchy of your headings in HTML documents is correct. This means you should start your document with a H1, use H2 for sections, use H3 for subsections, etc. So don't skip any levels.

Sometimes it can be quite difficult to style these headings. One way to make this easier is to use heading classes, instead of styling the heading tags directly.

So you would do:

    .page-heading {
        font-size:32px;
    }

Instead of:

    h1 {
        font-size:32px;
    }

Then this gives you always the option to do:

    <h2 class="page-heading">

Or change it even to this, if that helps in fixing the hierarchy of the headings:

    <h3 class="page-heading">

.edit
--

When you develop dynamic websites, a lot of markup comes from WYSIWYG editors. I like to control that content. So, in every template I wrap every piece of such content in a `<div class="edit">`.

Then you should place all styles for that `.edit` class at the bottom of your stylesheet. This is a kind of CSS reset in a way, since you can redefine all general elements again and have full control over that elements.

.mute
--

There are two tags to emphasize text in HTML: `<em>` and `<strong>`. But why isn't there a tag to *mute* content? That's why I often use a `.mute` class, which could be something like this:

    .mute {
        color:#CCC;
    }
