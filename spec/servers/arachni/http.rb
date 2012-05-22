require 'sinatra'
require 'sinatra/contrib'
set :logging, false

get '/' do
    'GET'
end

post '/' do
    'POST'
end

delete '/' do
    'DELETE'
end

put '/' do
    'PUT'
end

options '/' do
    'OPTIONS'
end

get '/echo' do
    params.to_s
end

get '/elems' do
    <<-EOHTML
    <a href='/stuff'></a>
    EOHTML
end

get '/sleep' do
    sleep 5
end

get '/cookies' do
    cookies.map { |k, v| k.to_s + '=' + v.to_s }.join( ";" )
end

get '/headers' do
    env['HTTP_MY_HEADER'].to_s
    hash = env.reject{ |k, v| !k.to_s.downcase.include?( 'http' ) }.inject({}) do |h, (k, v)|
        k = k.split( '_' )[1..-1].map { |s| s.capitalize }.join( '-' )
        h[k] = v || ''; h
    end
    hash.to_yaml
end

get '/update_cookies' do
    cookies[cookies.keys.first] = cookies.values.first + ' [UPDATED!]'
end

get '/follow_location' do
    redirect '/redir_1'
end

get '/redir_1' do
    redirect '/redir_2'
end

get '/redir_2' do
    'Welcome to redir_2!'
end

get '/custom_404/not' do
    'This is not a custom 404, watch out.'
end

get '/custom_404/static/*' do
    'This is a custom 404, try to catch it. ;)'
end

get '/custom_404/dynamic/*' do
    'This is a custom 404 which includes the requested resource, try to catch it. ;)' +
        '<br/>You asked for "' + params[:splat].first.to_s + '", which could not be found.'
end

get '/custom_404/random/*' do
    'This is a custom 404, try to catch it. ;)<br/> Random bit: ' + rand( 999 ).to_s
end

get '/custom_404/combo/*' do
    'This is a custom 404, try to catch it. ;)<br/> Random bit: ' + rand( 999 ).to_s +
        '<br/>You asked for "' + params[:splat].first.to_s + '", which could not be found.'
end
