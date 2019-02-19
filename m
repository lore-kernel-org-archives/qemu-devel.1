Received: from eggs.gnu.org ([209.51.188.92]:42095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gwDba-00018q-5X
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gwDMw-0007Ci-FN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:56:03 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gwDMw-000777-7e
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:56:02 -0500
Received: by mail-pl1-x643.google.com with SMTP id 101so11073337pld.6
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 13:55:57 -0800 (PST)
Date: Tue, 19 Feb 2019 13:55:54 -0800 (PST)
In-Reply-To: <1550565421-10944-12-git-send-email-thuth@redhat.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-6f2b26db-fa0b-4d44-95e0-be09a173fb72@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/14] MAINTAINERS: Clean up the RISC-V TCG
 backend section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>

On Tue, 19 Feb 2019 00:36:58 PST (-0800), thuth@redhat.com wrote:
> The e-mail address mjc@sifive.com of Micheal is not valid anymore.
> Commit 7d04ac38959f8115f2a02 removed the entry already from the main
> RISC-V section, but apparently forgot to remove it from the TCG
> backend section, too.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Fixes: 7d04ac38959f8115f2a029d81db1c8aac179aa95
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I'm assuming this is going in through another tree, but let me know if you want 
me to take it.

Thanks!

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b00caaf..1d0dcde 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2232,7 +2232,6 @@ F: tcg/ppc/
>  F: disas/ppc.c
>
>  RISC-V
> -M: Michael Clark <mjc@sifive.com>
>  M: Palmer Dabbelt <palmer@sifive.com>
>  M: Alistair Francis <Alistair.Francis@wdc.com>
>  L: qemu-riscv@nongnu.org
