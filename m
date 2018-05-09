Received: from eggs.gnu.org ([2001:4830:134:3::10]:41710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWNb-0002Qr-Gq
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWNY-0006m4-7i
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:12:07 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:34191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGWNY-0006lr-1H
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:12:04 -0400
Received: by mail-pg0-x230.google.com with SMTP id g20-v6so16534176pgv.1
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 14:12:04 -0700 (PDT)
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-28-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7bb4f65e-d845-03ef-4909-f72a6a6b3505@linaro.org>
Date: Wed, 9 May 2018 14:12:00 -0700
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-28-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 27/36] target-microblaze: mmu: Add a
 configurable output address mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 05/08/2018 10:31 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add a configurable output address mask, used to mimic the
> configurable physical address bit width.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/cpu.c | 1 +
>  target/microblaze/mmu.c | 1 +
>  target/microblaze/mmu.h | 1 +
>  3 files changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
