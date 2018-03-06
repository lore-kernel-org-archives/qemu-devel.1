Received: from eggs.gnu.org ([2001:4830:134:3::10]:40505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLrk-0000RC-Od
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLrg-0001S5-QO
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:19:28 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLrg-0001Rf-Iy
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:19:24 -0500
Received: by mail-wm0-x242.google.com with SMTP id a20so20169216wmd.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 15:19:24 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306024328.19195-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c34d4e8-056e-ee3a-5765-64e1b0cc4464@amsat.org>
Date: Tue, 6 Mar 2018 20:19:22 -0300
MIME-Version: 1.0
In-Reply-To: <20180306024328.19195-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] README: Fix typo 'git-publish'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com

On 03/05/2018 11:43 PM, Fam Zheng wrote:
> Reported-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 7833b97365..49a9fd09cd 100644
> --- a/README
> +++ b/README
> @@ -73,7 +73,7 @@ The QEMU website is also maintained under source control.
>    git clone git://git.qemu.org/qemu-web.git
>    https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/
>  
> -A 'git-profile' utility was created to make above process less
> +A 'git-publish' utility was created to make above process less
>  cumbersome, and is highly recommended for making regular contributions,
>  or even just for sending consecutive patch series revisions. It also
>  requires a working 'git send-email' setup, and by default doesn't
> 
