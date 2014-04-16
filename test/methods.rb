def move_out_posts_and_start_jekyll
	system('mv -f _posts/ tmp_posts/ ')
	system('jekyll serve -q -w --detach --port 5798 > /dev/null 2>&1')
end

def move_in_posts_and_kill_jekyll
	system('mv tmp_posts/ _posts/')
	pid = `lsof -twni tcp:5798`
	system("kill -9 #{pid} > /dev/null 2>&1")
	system('jekyll build -q > /dev/null 2>&1')
end

def path_to(page)
	"http://0.0.0.0:5798/#{page}/"
end

def get_noticias_videos_section
	@noticias = @browser.section :class => "noticias"
	@videos = @browser.section :class => "videos"
end
