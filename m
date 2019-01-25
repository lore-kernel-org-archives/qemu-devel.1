Received: from eggs.gnu.org ([209.51.188.92]:36030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gnAcb-0004QJ-Jd
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:10:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gnAZe-0005Rq-Sc
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:07:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gnAZe-0005R9-Mu
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:07:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so8109967wmc.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 15:07:46 -0800 (PST)
References: <20190125222113.31183-1-palmer@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ea2971d8-37e2-9d7b-8a9d-cc52aafa8467@redhat.com>
Date: Sat, 26 Jan 2019 00:07:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190125222113.31183-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Remove Michael Clark as a
 RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 1/25/19 11:21 PM, Palmer Dabbelt wrote:
> Michael is no longer employed by SiFive and does not want to continue
> maintianing the RISC-V port.

"maintaining"

> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af339b86db76..47cb3c14298e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -259,7 +259,6 @@ F: include/hw/ppc/
>  F: disas/ppc.c
>  
>  RISC-V
> -M: Michael Clark <mjc@sifive.com>
>  M: Palmer Dabbelt <palmer@sifive.com>
>  M: Alistair Francis <Alistair.Francis@wdc.com>
>  M: Sagar Karandikar <sagark@eecs.berkeley.edu>
> 
