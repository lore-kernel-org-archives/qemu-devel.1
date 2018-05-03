Received: from eggs.gnu.org ([2001:4830:134:3::10]:40116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEJWf-0005S2-Bl
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEJWa-0007RH-G2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:04:21 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEJWa-0007Q7-BC
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:04:16 -0400
Received: by mail-pf0-x244.google.com with SMTP id a22so1359565pfn.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 12:04:16 -0700 (PDT)
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-22-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <289bc1f7-9937-2976-324c-452c029d27a1@linaro.org>
Date: Thu, 3 May 2018 12:04:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180503091922.28733-22-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 21/29] target-microblaze: Setup for
 64bit addressing
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

On 05/03/2018 02:19 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Setup MicroBlaze builds for 64bit addressing.
> No functional change since the translator does not yet
> emit 64bit addresses.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  configure               | 1 +
>  target/microblaze/cpu.h | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
