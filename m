Received: from eggs.gnu.org ([2001:4830:134:3::10]:48605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJMr3-00020g-Hv
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJMqz-0005iw-Kk
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:38:17 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:35159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJMqz-0005ie-EK
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:38:13 -0400
Received: by mail-pl0-x243.google.com with SMTP id i5-v6so2965371plt.2
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:38:13 -0700 (PDT)
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-38-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7d736efa-d7ba-73ec-a653-215ce4f44f8b@linaro.org>
Date: Thu, 17 May 2018 10:38:09 -0700
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-38-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 37/38] target-microblaze: cpu_mmu_index:
 Fixup indentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 05/16/2018 11:51 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Fixup the indentation of cpu_mmu_index in preparation for
> future edits.
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/cpu.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
