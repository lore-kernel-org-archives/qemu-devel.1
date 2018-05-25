Received: from eggs.gnu.org ([2001:4830:134:3::10]:54350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMEJf-0005O3-01
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMEJb-000550-6f
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:07:38 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:46866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMEJb-00054m-0a
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:07:35 -0400
Received: by mail-pl0-x241.google.com with SMTP id 30-v6so3320244pld.13
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 08:07:34 -0700 (PDT)
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-2-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a7a51bf4-5b67-2425-38e5-6cb0f8bcf4cb@linaro.org>
Date: Fri, 25 May 2018 08:07:30 -0700
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-2-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 01/30] RISC-V: Update address bits to
 support sv39 and sv48
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On 05/22/2018 05:14 PM, Michael Clark wrote:
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  target/riscv/cpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
