Received: from eggs.gnu.org ([2001:4830:134:3::10]:58114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZdue-0001Fh-TR
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZdua-00031a-EU
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:33:00 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZdua-0002zt-7n
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:32:56 -0500
Received: by mail-pf0-x243.google.com with SMTP id t12so1768211pfg.2
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 06:32:56 -0800 (PST)
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-4-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e6ab6b22-722e-5dbf-f0f4-26165d3c51cf@linaro.org>
Date: Thu, 11 Jan 2018 06:32:52 -0800
MIME-Version: 1.0
In-Reply-To: <1515637324-96034-4-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/21] RISC-V CPU Core Definition
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

On 01/10/2018 06:21 PM, Michael Clark wrote:
> Add CPU state header, CPU definitions and initialization routines
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/cpu.c      | 391 +++++++++++++++++++++++++++++++++++++++++++++
>  target/riscv/cpu.h      | 271 +++++++++++++++++++++++++++++++
>  target/riscv/cpu_bits.h | 417 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1079 insertions(+)
>  create mode 100644 target/riscv/cpu.c
>  create mode 100644 target/riscv/cpu.h
>  create mode 100644 target/riscv/cpu_bits.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
