Received: from eggs.gnu.org ([2001:4830:134:3::10]:38955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejnLK-0004Ld-2h
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejnLG-0000F8-5S
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:38:30 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejnLF-0000DM-VU
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:38:26 -0500
Received: by mail-pf0-x243.google.com with SMTP id b25so1793194pfd.9
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 06:38:25 -0800 (PST)
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-8-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <55fffeaf-ec21-ad50-1274-dece7eae5608@linaro.org>
Date: Thu, 8 Feb 2018 06:38:21 -0800
MIME-Version: 1.0
In-Reply-To: <1518053328-34687-8-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 07/23] RISC-V FPU Support
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
> Helper routines for FPU instructions and NaN definitions.
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  fpu/softfloat-specialize.h |   7 +-
>  target/riscv/fpu_helper.c  | 375 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 379 insertions(+), 3 deletions(-)
>  create mode 100644 target/riscv/fpu_helper.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
