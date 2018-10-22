Received: from eggs.gnu.org ([2001:4830:134:3::10]:58138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gEYzy-0008CU-E3
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gEYzs-0003g9-Mi
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:07:54 -0400
Received: from mail-co1nam03on0104.outbound.protection.outlook.com
	([104.47.40.104]:43424
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gEYzs-0003eq-E8
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:07:48 -0400
References: <1540209445-28831-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540209445-28831-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Stefan Markovic <smarkovic@wavecomp.com>
Message-ID: <990728f6-2125-e6f0-caaa-279e7115ef97@wavecomp.com>
Date: Mon, 22 Oct 2018 14:07:42 +0200
MIME-Version: 1.0
In-Reply-To: <1540209445-28831-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Fix the title of
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, pjovanovic@wavecomp.com


On 22.10.18. 13:57, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Replace MIPS32 with MIPS, since the file covers all generations
> of MIPS architectures.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   target/mips/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>


> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 74ef160..1afb105 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1,5 +1,5 @@
>   /*
> - *  MIPS32 emulation for qemu: main translation routines.
> + *  MIPS emulation for QEMU: main translation routines.
>    *
>    *  Copyright (c) 2004-2005 Jocelyn Mayer
>    *  Copyright (c) 2006 Marius Groeger (FPU operations)
