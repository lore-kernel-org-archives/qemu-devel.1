Received: from eggs.gnu.org ([2001:4830:134:3::10]:33453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f2p7X-0000C9-6X
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 22:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f2p7T-0000AU-4k
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 22:22:55 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:52632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f2p7S-00009o-UG
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 22:22:51 -0400
Received: by mail-wm0-f49.google.com with SMTP id l9so23005101wmh.2
	for <qemu-devel@nongnu.org>; Sun, 01 Apr 2018 19:22:50 -0700 (PDT)
References: <20180401162258.36206-1-raimue@macports.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <357029f4-71c0-a9f9-7bda-a5a44f609b27@redhat.com>
Date: Mon, 2 Apr 2018 04:22:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180401162258.36206-1-raimue@macports.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add instructions for
 MacPorts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Rainer_M=c3=bcller?= <raimue@macports.org>, qemu-devel@nongnu.org

On 01/04/2018 18:22, Rainer Müller wrote:
> Signed-off-by: Rainer Müller <raimue@macports.org>
> ---
>  _download/macos.md | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/_download/macos.md b/_download/macos.md
> index dbb312c..06aa811 100644
> --- a/_download/macos.md
> +++ b/_download/macos.md
> @@ -1,6 +1,10 @@
> -QEMU can be installed from Homebrew:
> +QEMU can be installed from <strong>Homebrew</strong>:
>  
>  <pre>brew install qemu</pre>
>  
> +QEMU can be installed from <strong>MacPorts</strong>:
> +
> +<pre>sudo port install qemu</pre>
> +
>  QEMU requires Mac OS X 10.5 or later, but it is recommended
>  to use Mac OS X 10.7 or later.
> 

Thanks for the patch!  I'm travelling but I will apply it as soon as I can.

Paolo
