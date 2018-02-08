Received: from eggs.gnu.org ([2001:4830:134:3::10]:39323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejpCQ-0007mF-2b
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejpCN-0003np-WE
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:37:26 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejpCN-0003n3-Qi
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:37:23 -0500
Received: by mail-pg0-x242.google.com with SMTP id u1so1792769pgr.0
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:37:23 -0800 (PST)
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-14-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <68d3a0fc-5569-7b1e-8456-16973d57fd04@linaro.org>
Date: Thu, 8 Feb 2018 08:37:20 -0800
MIME-Version: 1.0
In-Reply-To: <1518053328-34687-14-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 13/23] RISC-V HART Array
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
> Holds the state of a heterogenous array of RISC-V hardware threads.
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  hw/riscv/riscv_hart.c         | 95 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/riscv_hart.h | 45 ++++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 hw/riscv/riscv_hart.c
>  create mode 100644 include/hw/riscv/riscv_hart.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
