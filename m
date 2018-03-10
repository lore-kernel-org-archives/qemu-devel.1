Received: from eggs.gnu.org ([2001:4830:134:3::10]:37667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eul9Z-0003mD-7D
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eul9W-0005vi-3m
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:31:41 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eul9V-0005vU-Sr
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:31:38 -0500
Received: by mail-wm0-x241.google.com with SMTP id t6so9494891wmt.5
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 12:31:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
	<1520568765-58189-15-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f5c22b39-0f5a-80be-08b2-2f647615b222@amsat.org>
Date: Sat, 10 Mar 2018 21:31:34 +0100
MIME-Version: 1.0
In-Reply-To: <1520568765-58189-15-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/23] RISC-V: Make virt header comment
 title consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 03/09/2018 05:12 AM, Michael Clark wrote:
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/riscv/virt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 3a4f23e..91163d6 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -1,5 +1,5 @@
>  /*
> - * SiFive VirtIO Board
> + * QEMU RISC-V VirtIO machine interface
>   *
>   * Copyright (c) 2017 SiFive, Inc.
>   *
> 
