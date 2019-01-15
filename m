Received: from eggs.gnu.org ([209.51.188.92]:59560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjX5W-0003o4-VG
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjX5V-0007BO-24
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:21:38 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjX5U-00074S-HB
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:21:36 -0500
Received: by mail-pl1-x642.google.com with SMTP id g9so1960908plo.3
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 14:21:33 -0800 (PST)
References: <cover.1547510220.git.alistair.francis@wdc.com>
	<20ba320ced470eed0f16b39e01b1bf8c24dbd3c4.1547510220.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <18f89999-7b17-d858-0efc-45aa02d65785@linaro.org>
Date: Wed, 16 Jan 2019 09:21:26 +1100
MIME-Version: 1.0
In-Reply-To: <20ba320ced470eed0f16b39e01b1bf8c24dbd3c4.1547510220.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/8] RISC-V: Use riscv prefix
 consistently on cpu helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 1/15/19 10:58 AM, Alistair Francis wrote:
> From: Michael Clark <mjc@sifive.com>
> 
> * Add riscv prefix to raise_exception function
> * Add riscv prefix to CSR read/write functions
> * Add riscv prefix to signal handler function
> * Add riscv prefix to get fflags function
> * Remove redundant declaration of riscv_cpu_init
>   and rename cpu_riscv_init to riscv_cpu_init
> * rename riscv_set_mode to riscv_cpu_set_mode
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
