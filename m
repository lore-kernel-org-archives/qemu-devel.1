Received: from eggs.gnu.org ([2001:4830:134:3::10]:59575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1db1PR-0003pl-Jm
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1db1PQ-0004n2-9h
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:18:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-31-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-31-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 28 Jul 2017 11:17:49 +0200
Message-ID: <CACXAS8BfLgi5X1rKHDm05RmvE7WMWUtOqQ=roRUtzRQ22yCqmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 30/47] MAINTAINERS: add missing SPARC entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org

On Fri, Jul 28, 2017 at 7:35 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-By: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bb1cb1fc1c..e363a18631 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -245,6 +245,7 @@ F: target/sparc/
>  F: hw/sparc/
>  F: hw/sparc64/
>  F: disas/sparc.c
> +F: default-configs/sparc*-softmmu.mak
>
>  UniCore32
>  M: Guan Xuetao <gxt@mprc.pku.edu.cn>
> --
> 2.13.3
>



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
