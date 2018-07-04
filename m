Received: from eggs.gnu.org ([2001:4830:134:3::10]:60649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fao5R-00085o-UR
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fao5O-0003be-9E
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:09:13 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:44373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fao5O-0003bA-4j
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:09:10 -0400
Received: by mail-qk0-x244.google.com with SMTP id v17-v6so943271qkb.11
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 13:09:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530732637-28606-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2d3cf4fc-f83e-bb2f-1c5d-c40770e0ea7e@amsat.org>
Date: Wed, 4 Jul 2018 17:09:04 -0300
MIME-Version: 1.0
In-Reply-To: <1530732637-28606-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/8] target/mips: Update maintainer's
 email addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

Hi Aleksandar,

It's a bit funny you sent this email from yet another company, RT-RK =)

The mips.com is dead, long live the MIPS!

On 07/04/2018 04:30 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Update email addresses of Aleksandar Markovic and Paul Burton in the
> MAINTAINERS file. Also, add corresponding items in the .mailmap file.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  .mailmap    | 7 +++++--
>  MAINTAINERS | 9 +++++----
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 778a4d4..2c2b9b1 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -12,8 +12,11 @@ Fabrice Bellard <fabrice@bellard.org> bellard <bellard@c046a42c-6fe2-441c-8c8c-7
>  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>  Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>

> +Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.com>
> +Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec.com>
> +Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
> -Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
> +Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
> -Paul Burton <paul.burton@mips.com> <paul@archlinuxmips.org>
> +Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>

reordered a bit to follow, ok.

>  Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-71466251a162>
>  malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6630d69..f3863b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -187,7 +187,7 @@ F: disas/microblaze.c
>  
>  MIPS
>  M: Aurelien Jarno <aurelien@aurel32.net>
> -M: Aleksandar Markovic <aleksandar.markovic@mips.com>
> +M: Aleksandar Markovic <amarkovic@wavecomp.com>
>  S: Maintained
>  F: target/mips/
>  F: hw/mips/
> @@ -718,7 +718,7 @@ S: Maintained
>  F: hw/mips/mips_malta.c
>  
>  Mipssim
> -M: Aleksandar Markovic <aleksandar.markovic@mips.com>
> +M: Aleksandar Markovic <amarkovic@wavecomp.com>
>  S: Odd Fixes
>  F: hw/mips/mips_mipssim.c
>  F: hw/net/mipsnet.c
> @@ -729,14 +729,15 @@ S: Maintained
>  F: hw/mips/mips_r4k.c
>  
>  Fulong 2E
> -M: Aleksandar Markovic <aleksandar.markovic@mips.com>
> +M: Aleksandar Markovic <amarkovic@wavecomp.com>
>  S: Odd Fixes
>  F: hw/mips/mips_fulong2e.c
>  F: hw/isa/vt82c686.c
> +
>  F: include/hw/isa/vt82c686.h
>  
>  Boston
> -M: Paul Burton <paul.burton@mips.com>
> +M: Paul Burton <pburton@wavecomp.com>
>  S: Maintained
>  F: hw/core/loader-fit.c
>  F: hw/mips/boston.c

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
