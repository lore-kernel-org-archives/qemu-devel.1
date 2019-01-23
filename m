Received: from eggs.gnu.org ([209.51.188.92]:58660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmNGq-00058q-T1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmNGp-0005n4-9e
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:29:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmNGp-0005ln-0c
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:29:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so3634219wrr.12
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 10:29:01 -0800 (PST)
References: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1548242160-16039-10-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <544d3c67-c766-6069-607b-97bf32cf40f6@redhat.com>
Date: Wed, 23 Jan 2019 19:28:59 +0100
MIME-Version: 1.0
In-Reply-To: <1548242160-16039-10-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 9/9] MAINTAINERS: Update MIPS sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 1/23/19 12:16 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Remove Stefan Markovic as a reviewer for MIPS directories and
> files, as he left Wave Computing.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af339b8..060db23 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -206,7 +206,6 @@ MIPS
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
> -R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: target/mips/
>  F: default-configs/*mips*
> @@ -365,7 +364,6 @@ F: target/arm/kvm.c
>  MIPS
>  M: James Hogan <jhogan@kernel.org>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
> -R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: target/mips/kvm.c
>  
> @@ -890,7 +888,6 @@ MIPS Machines
>  Jazz
>  M: Hervé Poussineau <hpoussin@reactos.org>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
> -R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/mips/mips_jazz.c
>  F: hw/display/jazz_led.c
> @@ -899,14 +896,12 @@ F: hw/dma/rc4030.c
>  Malta
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
> -R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/mips/mips_malta.c
>  
>  Mipssim
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
> -R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Odd Fixes
>  F: hw/mips/mips_mipssim.c
>  F: hw/net/mipsnet.c
> @@ -914,14 +909,12 @@ F: hw/net/mipsnet.c
>  R4000
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
> -R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/mips/mips_r4k.c
>  
>  Fulong 2E
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
> -R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Odd Fixes
>  F: hw/mips/mips_fulong2e.c
>  F: hw/isa/vt82c686.c
> @@ -931,7 +924,6 @@ F: include/hw/isa/vt82c686.h
>  Boston
>  M: Paul Burton <pburton@wavecomp.com>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
> -R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/core/loader-fit.c
>  F: hw/mips/boston.c
> @@ -2203,7 +2195,6 @@ F: disas/i386.c
>  MIPS target
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
> -R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: tcg/mips/
>  F: disas/mips.c
> 
