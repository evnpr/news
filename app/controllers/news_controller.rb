class NewsController < ApplicationController


  def index
        if request.post?
            urlpost = params[:url]
            if urlpost.match("http").nil? # domain -> http://domain
                urlpost = "http://"+urlpost
                @url = urlpost
            end
            @sourcepage = `php #{Rails.root}/get.php #{urlpost}`

            unless @sourcepage.nil?
               a = @sourcepage.force_encoding("ISO-8859-1").encode("utf-8", replace: nil)
               unless News.exists?(:url => urlpost)
                   n = News.new(:url=>urlpost)
               else
                   flash[:index] = "already exists"
                   redirect_to "/" and return
               end
               if a.match('<title>')
                    @title = a.split('<title>')[1].split('</title>')[0]
                    unless News.exists?(:title => @title)
                        unless n.nil?
                            n.title = @title
                        end
                    else
                        flash[:index] = "already exists"
                        redirect_to "/" and return
                    end
               end
               if a.match('name="description" content=')
                    @meta = a.split('name="description" content=')[1].split('"')[1]
               end
               unless n.nil?
                   n.description = @meta
                   n.save
               end
            end
            flash[:success] = "successfully submit"
            redirect_to "/" and return
        else
            page = params[:page].to_i
            @news = News.all(:order => "id DESC", :limit => 10, :offset => (page-1)*10)
            @pages = News.count / 10
            unless page==1
                @prev = page - 1
            else
                @prev = page
            end
            unless page==@pages+1
                if page == 0
                    page = 1
                end
                @next = page + 1
            else
                @next = page
            end
        end
  end
  
  def upload
    
        uploaded_files = params[:file]
          if uploaded_files.nil?
            flash[:list] = "you are not uploading any folder/files"
            redirect_to "/" and return
          end     
          uploaded_files.each do |u|
              File.open("/var/www/ls/upload/libranews+"/public/"+u.original_filename, 'wb') do |file|
                file.write(u.read)
                file.close
              end
          end
          
          redirect_to "/" and return
        end
    
  end
  
  
end



