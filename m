Received: from eggs.gnu.org ([2001:4830:134:3::10]:52363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7Ur-0005md-89
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7Uq-0007UK-FL
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:27:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170926202512.37670-1-carenas@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cdfde400-e8d7-4733-a872-b6f83c0b7183@amsat.org>
Date: Fri, 29 Sep 2017 20:45:16 -0300
MIME-Version: 1.0
In-Reply-To: <20170926202512.37670-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] gitignore: ignore check-qlit test
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 09/26/2017 05:25 PM, Carlo Marcelo Arenas Belón wrote:
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/.gitignore b/tests/.gitignore
> index cf6d99c91e..53cb2efaee 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -6,6 +6,7 @@ check-qdict
>   check-qnum
>   check-qjson
>   check-qlist
> +check-qlit
>   check-qnull
>   check-qstring
>   check-qom-interface
> 
