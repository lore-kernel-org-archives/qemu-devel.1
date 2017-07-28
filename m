Received: from eggs.gnu.org ([2001:4830:134:3::10]:39198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dazNc-0007o5-7i
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dazNY-0003oj-KV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:08:12 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-16-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a4a9c830-1047-c0f1-918d-d1543c881cd6@redhat.com>
Date: Fri, 28 Jul 2017 09:08:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-16-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 15/47] MAINTAINERS: add missing VMWare
 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Dmitry Fleytman <dmitry@daynix.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 28.07.2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>=20
> RFC because I'm not sure about tests/

I think that should be fine, we've got a couple of such entries already
in the MAINTAINERS file.

>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d8aef164ca..9670a3901a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1140,6 +1140,7 @@ M: Dmitry Fleytman <dmitry@daynix.com>
>  S: Maintained
>  F: hw/net/vmxnet*
>  F: hw/scsi/vmw_pvscsi*
> +F: tests/vmxnet3-test.c
> =20

Reviewed-by: Thomas Huth <thuth@redhat.com>
