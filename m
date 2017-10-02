Received: from eggs.gnu.org ([2001:4830:134:3::10]:34541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dz5dL-0001P7-01
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dz5dF-0001kA-D4
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:40:03 -0400
MIME-Version: 1.0
In-Reply-To: <20170926202512.37670-1-carenas@gmail.com>
References: <20170926202512.37670-1-carenas@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Oct 2017 11:39:25 -0700
Message-ID: <CAKmqyKMQOWqOJmhcTMfex_O-SvSARGAdRHuOYnsw=7izM3p=KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gitignore: ignore check-qlit test
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Tue, Sep 26, 2017 at 1:25 PM, Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

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
> --
> 2.13.5 (Apple Git-94)
>
>
