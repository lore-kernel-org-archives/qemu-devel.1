Received: from eggs.gnu.org ([2001:4830:134:3::10]:51076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCPpa-0001FP-My
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCPpU-0002xd-Va
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:51:46 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170926210723.38042-1-carenas@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cab436f4-5d5c-485e-a7da-0d844429c5a4@amsat.org>
Date: Wed, 8 Nov 2017 09:51:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170926210723.38042-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] gitignore: ignore check-qlit test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com

On 09/26/2017 06:07 PM, Carlo Marcelo Arenas Belón wrote:
> test introduced in 382176b4d78e070d119af8e0dcd00884c11bbec2
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/.gitignore b/tests/.gitignore
> index cf6d99c91e..53cb2efaee 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -6,6 +6,7 @@ check-qdict
>  check-qnum
>  check-qjson
>  check-qlist
> +check-qlit
>  check-qnull
>  check-qstring
>  check-qom-interface
> 
