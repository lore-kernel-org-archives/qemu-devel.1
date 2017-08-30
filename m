Received: from eggs.gnu.org ([2001:4830:134:3::10]:39259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dnCBD-0004Zx-Hu
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 19:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dnCBC-0007u0-Pr
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 19:13:51 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170830215523.25278-15-f4bug@amsat.org>
References: <20170830215523.25278-1-f4bug@amsat.org>
	<20170830215523.25278-15-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 30 Aug 2017 16:13:13 -0700
Message-ID: <CAKmqyKPVcUF1q2fzdECnun04m2XryXquk67tPvLEpcXmP9c84Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/17] MAINTAINERS: add missing entry
 for Generic Loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Aug 30, 2017 at 2:55 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a48f633cad..0b77590dc8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1164,6 +1164,7 @@ M: Alistair Francis <alistair.francis@xilinx.com>
>  S: Maintained
>  F: hw/core/generic-loader.c
>  F: include/hw/core/generic-loader.h
> +F: docs/generic-loader.txt
>
>  CHRP NVRAM
>  M: Thomas Huth <thuth@redhat.com>
> --
> 2.14.1
>
>
