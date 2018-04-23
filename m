Received: from eggs.gnu.org ([2001:4830:134:3::10]:60762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAhCv-0003cu-KV
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAhCs-00015Y-II
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:33:01 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:42543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fAhCs-000157-CN
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:32:58 -0400
Received: by mail-pf0-x236.google.com with SMTP id o16so10128838pfk.9
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 12:32:58 -0700 (PDT)
References: <20180423123225.30503-1-edgar.iglesias@gmail.com>
	<20180423123225.30503-5-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <562480b1-eb5f-c935-cc91-d596ad85b331@linaro.org>
Date: Mon, 23 Apr 2018 09:32:53 -1000
MIME-Version: 1.0
In-Reply-To: <20180423123225.30503-5-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target-microblaze: mmu: Make TLBSX
 write-only
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
> Make TLBSX write-only and guest-error log reads from it.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/mmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
