Received: from eggs.gnu.org ([209.51.188.92]:52285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQlB-0000NX-8e
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQl5-0006Fy-Si
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:01:46 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvQl1-000646-9w
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:01:39 -0500
Received: by mail-pf1-x442.google.com with SMTP id v21so4353703pfm.12
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 10:01:26 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2ef73e98-579f-061b-9d70-54a5b03c54a7@linaro.org>
Date: Sun, 17 Feb 2019 10:01:20 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/14] hw/arm/armsse: Document
 SRAM_ADDR_WIDTH property in header comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 2/14/19 4:51 AM, Peter Maydell wrote:
> In commit 4b635cf7a95e501211 we added a QOM property to the ARMSSE
> object, but forgot to add it to the documentation comment in the
> header. Correct the omission.
> 
> Fixes: 4b635cf7a95e501211 ("hw/arm/armsse: Make SRAM bank size configurable")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
