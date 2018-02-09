Received: from eggs.gnu.org ([2001:4830:134:3::10]:54579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekEYt-0003z0-Fj
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekEYq-0004Eg-DJ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:42:19 -0500
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:38129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekEYq-0004EI-5N
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:42:16 -0500
Received: by mail-pl0-x22f.google.com with SMTP id 13so1919319plb.5
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 11:42:16 -0800 (PST)
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2832ff22-e0c8-85b9-c0ce-15b0cc3cdc72@linaro.org>
Date: Fri, 9 Feb 2018 11:42:11 -0800
MIME-Version: 1.0
In-Reply-To: <1518053328-34687-1-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/07/2018 05:28 PM, Michael Clark wrote:
>  create mode 100644 hw/riscv/Makefile.objs
>  create mode 100644 hw/riscv/riscv_elf.c
>  create mode 100644 hw/riscv/riscv_hart.c
>  create mode 100644 hw/riscv/riscv_htif.c
>  create mode 100644 hw/riscv/sifive_clint.c
>  create mode 100644 hw/riscv/sifive_e300.c
>  create mode 100644 hw/riscv/sifive_plic.c
>  create mode 100644 hw/riscv/sifive_prci.c
>  create mode 100644 hw/riscv/sifive_test.c
>  create mode 100644 hw/riscv/sifive_u500.c
>  create mode 100644 hw/riscv/sifive_uart.c
>  create mode 100644 hw/riscv/spike_v1_09.c
>  create mode 100644 hw/riscv/spike_v1_10.c
>  create mode 100644 hw/riscv/virt.c

I have no plans to review these last 9 patches.
They all look plausible to me, but I'm not so
up-to-date on best practices within hw/.


r~
