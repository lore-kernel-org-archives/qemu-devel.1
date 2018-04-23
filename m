Received: from eggs.gnu.org ([2001:4830:134:3::10]:60893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAhDT-0003sS-5D
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAhDQ-0001Hm-1n
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:33:35 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:41406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fAhDP-0001HW-SJ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:33:31 -0400
Received: by mail-pg0-x22c.google.com with SMTP id m21so6060995pgv.8
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 12:33:31 -0700 (PDT)
References: <20180423123225.30503-1-edgar.iglesias@gmail.com>
	<20180423123225.30503-6-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9bb35b84-494e-ea9e-3794-e6e3d5ebb075@linaro.org>
Date: Mon, 23 Apr 2018 09:33:27 -1000
MIME-Version: 1.0
In-Reply-To: <20180423123225.30503-6-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] target-microblaze: mmu: Make the
 TLBX MISS bit read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

On 04/23/2018 02:32 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Make the TLBX MISS bit read-only.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/mmu.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
