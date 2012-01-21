module Nosy

  class Output

    module HtmlHelpers

      def generate_html(f, texts)
        f.puts "<!doctype html><head>#{head}<style>#{css}</style></head><body><div id='container'>"
          texts.each do |text|
            if text.sender == "me"
              f.puts "<article class='sending'>"
              html_text(f, text)
              f.puts "</article>"
            else
              f.puts "<article class='receiving'>"
              html_text(f, text)
              f.puts "</article>"
            end
            f.puts ""
            f.puts "<hr />"
            f.puts ""
          end
        f.puts "</div></body></html>"
      end

      def css
      "/* http://meyerweb.com/eric/tools/css/reset/ 
         v2.0 | 20110126
         License: none (public domain)
      */

      html, body, div, span, applet, object, iframe,
      h1, h2, h3, h4, h5, h6, p, blockquote, pre,
      a, abbr, acronym, address, big, cite, code,
      del, dfn, em, img, ins, kbd, q, s, samp,
      small, strike, strong, sub, sup, tt, var,
      b, u, i, center,
      dl, dt, dd, ol, ul, li,
      fieldset, form, label, legend,
      table, caption, tbody, tfoot, thead, tr, th, td,
      article, aside, canvas, details, embed, 
      figure, figcaption, footer, header, hgroup, 
      menu, nav, output, ruby, section, summary,
      time, mark, audio, video {
        margin: 0;
        padding: 0;
        border: 0;
        font-size: 100%;
        font: inherit;
        vertical-align: baseline;
      }
      /* HTML5 display-role reset for older browsers */
      article, aside, details, figcaption, figure, 
      footer, header, hgroup, menu, nav, section {
        display: block;
      }
      body {
        line-height: 1;
      }
      ol, ul {
        list-style: none;
      }
      blockquote, q {
        quotes: none;
      }
      blockquote:before, blockquote:after,
      q:before, q:after {
        content: '';
        content: none;
      }
      table {
        border-collapse: collapse;
        border-spacing: 0;
      }
        
        body{
          background: #f9f8f6;
          color: #606060;
          font-family: Helvetica, Arial, sans-serif;
          font-size: 18px;
          line-height: 1.8333em;
          padding: 40px 0;
          word-wrap: break-word;
          -webkit-font-smoothing: antialiased;
        }
        
        #container{
          width: 400px;
          margin: 0 auto;
          padding: 0 40px;
        }
        
      hr {
          border: none;
          background-color: #ccc;
          color: #ccc;
          height: 1px;
          margin: 45px 0;
      }

        article ul {
          margin: 40px 0 0 0;
        }
        
        article ul li {
          font-size: 0.6777em;
          padding: 0px;
          line-height: 1.7em;
        }
        
        article ul li.sender{
          font-size: 1.555em;
          font-weight: bold;
        }
        
        article.sending{
          text-align: right;
        }"
      end

      def head 
        "<meta charset='utf-8'>
        <title>Texts</title>
        <meta name='description' content=''>
        <meta name='author' content='Nosy - pdud - Phil Dudley - iPhone Message (SMS/ iMessage) Exporter'>
        <meta name='viewport' content='width=device-width, user-scalable=no'>
        <!-- IE Fix for HTML5 Tags -->
        <!--[if lt IE 9]>
          <script src='http://html5shiv.googlecode.com/svn/trunk/html5.js'></script>
        <![endif]-->"
      end

      def html_text (f, text)
        f.puts "<p>#{text.message}</p>"
        f.puts "<ul>"
        sender_html(f, text)
        f.puts "<li>#{Time.at(text.date).strftime('%A, %B %e, %Y at %l:%M%P')}</li>"
      end

      def sender_html(f, text)
        if text.sender == "me"
          f.puts "<li class='sender'>#{text.sender}</li>"
          f.puts "<li>to #{text.receiver} via #{imessage_or_sms(f, text)}</li>"
        else
          f.puts "<li class='sender'>#{text.sender}</li>"
          f.puts "<li>to #{text.receiver} via #{imessage_or_sms(f, text)}</li>"
        end
      end

      def imessage_or_sms(f, text)
        if text.imessage
          "iMessage"
        else
          "SMS"
        end
      end

    end
  end
end


