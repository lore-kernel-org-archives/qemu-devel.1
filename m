Received: from eggs.gnu.org ([2001:4830:134:3::10]:48839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqjBw-0004bd-Ry
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqjBw-0007B7-4Q
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:32:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170322115241.2810-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b8187938-4ab6-6915-d59b-5ca545502860@amsat.org>
Date: Wed, 22 Mar 2017 13:32:44 -0300
MIME-Version: 1.0
In-Reply-To: <20170322115241.2810-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] doc: fix function spelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 03/22/2017 08:52 AM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/io/channel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 5d48906998..db9bb022a1 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -315,7 +315,7 @@ ssize_t qio_channel_read(QIOChannel *ioc,
>                           Error **errp);
>
>  /**
> - * qio_channel_writev:
> + * qio_channel_write:
>   * @ioc: the channel object
>   * @buf: the memory regions to send data from
>   * @buflen: the length of @buf
>
