---
title: Hosting a static site on S3 with some ruby help
---

I recently did a one pager called [emoji-cheat-sheet.com](http://Emoji-cheat-sheet.com). The background to why I made this site is pretty simple, I like those little [emoji emoticons](http://en.wikipedia.org/wiki/Emoji). Both 37signals [Campfire](http://campfirenow.com/) and [GitHub](https://github.com/blog/816-emoji) supports emojis by using a syntax like <code>:cake:</code> which will generate a <img src="http://www.emoji-cheat-sheet.com/graphics/emojis/cake.png" height="22" width="22">. The problem is that there are quite a few emojis that you can use on these services and they support a different set of emoticons.<br>
I created a little cheat sheet that just lists which ones are supported on each service and put it online if someone else would be interested in it. If you got flash enabled you can just click the emoji code and it will be copied to your clipboard using [zClip](http://www.steamdev.com/zclip/). 

The site is basically one html file, a css file, a flash, a bit of javascript and a some graphic files. You can check out the source code on GitHub at [github.com/arvida/emoji-cheat-sheet.com](http://github.com/arvida/emoji-cheat-sheet.com). <br>As someone who usually writes ruby all day it's a pretty fun to do a small project where you are forced to think a bit about and try to do the web design for a site.

## S3 for hosting

As emoji-cheat-sheet.com is just a static site I decided to try out using Amazon's [S3](http://aws.amazon.com/s3/) for hosting it. There was basically two tiny issues I encountered:

* __You can't use naked domains__ S3 only works with CNAME records and I had to add a redirect for http://emoji-cheat-sheet.com that goes to http://www.emoji-cheat-sheet.com.
* __S3 defaults some files to <code>binary/octet-stream</code>__ If a browser get this mime-type for a file it expects it to be a binary file that should be downloaded to disk.

### How to do the S3 setup

Log into your AWS account and create a bucket that has the the same name as the domain your want to host on S3. The domain must include a ”www.” or be a subdomain.
Select your newly created bucket and click ”Properties” in the ”Action” popup menu. Choose the ”Website” tab, enable it and enter ”index.html” as the index document filename. Copy the the endpoint url and create a CNAME record for your domain that points to the endpoint. Now you just need to upload the files to the bucket.

## Making it easy to deploy with ruby

I did some quick googling trying to find a simple automated solution for uploading and minimizing files to S3 for sites like this but I didn't really find any solution. I ended up hacking together a little rake task using the excellent [fog gem](https://github.com/geemus/fog) for S3 interaction, detecting mime types with the old [mime-types](https://rubygems.org/gems/mime-types) gem and minimizing the css and js with [yuicompressor](http://developer.yahoo.com/yui/compressor/) (you can [install it using homebrew](https://github.com/mxcl/homebrew/blob/8cea07735e8c3cdc880e53dcc991b0d365478226/Library/Formula/yuicompressor.rb) these days). 

It is basically the two classes [Site](https://github.com/arvida/emoji-cheat-sheet.com/blob/8cea07735e8c3cdc880e53dcc991b0d365478226/Rakefile#L18) and [SiteFile](https://github.com/arvida/emoji-cheat-sheet.com/blob/8cea07735e8c3cdc880e53dcc991b0d365478226/Rakefile#L100) wrapped into a module called [SimpleS3Deploy](https://github.com/arvida/emoji-cheat-sheet.com/blob/8cea07735e8c3cdc880e53dcc991b0d365478226/Rakefile#L12) for simple interaction.

{% highlight ruby %}
module SimpleS3Deploy

  def self.deploy(site_path)
    Site.new(site_path).deploy
  end

  class Site
    # skipping some lines ..
    def deploy
      puts " ** Deploying #{path} to #{bucket.key}"
      puts " ==============================================="
      puts " ** Deleting existing remote files"
      clear_bucket
      puts " ** Uploading files"
      files.each do |file|
        if !File.directory?(file.path)
          remote_file_name = file_base_path(file.path)
          puts "      Uploading #{remote_file_name}"
          bucket.files.create(
            key: remote_file_name,
            body: file.is_minifyable? ? open(minify(file.path)) : open(file.path),
            public: true,
            content_type: file.mime_type,
            cache_control: 'max-age=604800, public' )
        end
      end
      if @tmp_files.any?
        puts " ** Cleaning up tmp files"
        cleanup
      end
      puts "** Done"
    end
    # skipping some lines ..
    def files
      @files ||= Dir.glob("#{path}/**/*").map { |f| SiteFile.new(f) }
    end

    def minify(file_path)
      "#{file_path}-tmp".tap do |tmp_file_name|
        `yuicompressor -o #{tmp_file_name} #{file_path}`
        tmp_files << tmp_file_name
      end
    end

    def bucket
      @bucket ||= s3.directories.get(config['s3']['bucket'])
    end

    def s3
      @s3 ||= Fog::Storage.new({
        provider: 'AWS',
        aws_secret_access_key: config['s3']['secret_access_key'],
        aws_access_key_id: config['s3']['access_key_id'] })
    end

  end

  class SiteFile
    # skipping some lines ..
    def is_minifyable?
      is_css_file? or is_js_file?
    end

    def is_css_file?
      path.end_with?('.css')
    end

    def is_js_file?
      path.end_with?('.js')
    end

    def mime_type
      MIME::Types.type_for(path)[0].to_s
    end

  end

end
{% endhighlight %}

The rake task:

{% highlight ruby %}
task :deploy do
  SimpleS3Deploy.deploy('public')
end
{% endhighlight %}

You can checkout the source code for this [on GitHub](https://github.com/arvida/emoji-cheat-sheet.com/blob/8cea07735e8c3cdc880e53dcc991b0d365478226/Rakefile). It's pretty basic stuff that has room for improvements and tests, but it makes deploying a static site like [emoji-cheat-sheet.com](http://emoji-cheat-sheet.com) to S3 much easier.

I think S3 is a pretty neat solution for hosting static sites, I like how easy it is to specify http headers for files and setting up a new site. The only downside is that it isn't super fast, but that is easy to fix by creating a CloudFront distribution that uses the S3 bucket as origin and pointing your domain the CloudFront distribution instead.
