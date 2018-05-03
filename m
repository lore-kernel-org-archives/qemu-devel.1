Received: from eggs.gnu.org ([2001:4830:134:3::10]:46134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIaS-0002pa-1k
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIaO-0008So-4q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:04:12 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:39082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEIaN-0008SV-UV
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:04:08 -0400
Received: by mail-pf0-x243.google.com with SMTP id a22so1236701pfn.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:04:07 -0700 (PDT)
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-6-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <64ee5be8-3946-8028-8f04-55a36724b886@linaro.org>
Date: Thu, 3 May 2018 11:04:04 -0700
MIME-Version: 1.0
In-Reply-To: <20180503091922.28733-6-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/29] target-microblaze: Correct
 special register array sizes
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

On 05/03/2018 02:18 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Correct special register array sizes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/cpu.h       | 4 ++--
>  target/microblaze/translate.c | 5 ++---
>  2 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
