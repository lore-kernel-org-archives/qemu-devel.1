Received: from eggs.gnu.org ([2001:4830:134:3::10]:33006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHARS-0004xC-JH
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHARO-0002O1-4Q
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:31:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHARN-0002NZ-UX
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:30:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id n5-v6so9373354wrw.12
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 09:30:57 -0700 (PDT)
References: <20181029161605.11486-1-palmer@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9cf83a16-250c-ff01-0783-74d5b2077999@redhat.com>
Date: Mon, 29 Oct 2018 17:30:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181029161605.11486-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Add Alistair as a RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

On 29/10/18 17:16, Palmer Dabbelt wrote:
> Alistair has been contributing to the RISC-V QEMU port for a while now
> so I'd like him to be officially listed as a maintainer.  I've checked
> with the other RISC-V mainatiners and there are no objectics, and I've

"maintainers" "objections"

> also checked with Alistair so he knows I'm volunteering him.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

FWIW:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d794bd7a66fe..d550fd8b809c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -241,6 +241,7 @@ F: disas/ppc.c
>   RISC-V
>   M: Michael Clark <mjc@sifive.com>
>   M: Palmer Dabbelt <palmer@sifive.com>
> +M: Alistair Francis <Alistair.Francis@wdc.com>
>   M: Sagar Karandikar <sagark@eecs.berkeley.edu>
>   M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>   S: Maintained
> 
