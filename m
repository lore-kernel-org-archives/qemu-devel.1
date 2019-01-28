Received: from eggs.gnu.org ([209.51.188.92]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9iJ-0008Jb-Gj
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9iH-00061Y-4w
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:24:47 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9iF-0005oV-4I
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:24:45 -0500
Received: by mail-pf1-x444.google.com with SMTP id y126so8218553pfb.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 08:24:19 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <12b083f4-4342-f448-5355-a91725daf609@linaro.org>
Date: Mon, 28 Jan 2019 08:24:15 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/23] hw/arm/armsse: Add
 unimplemented-device stub for cache control registers
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

On 1/21/19 10:51 AM, Peter Maydell wrote:
> The SSE-200 gives each CPU a register bank to use to control its
> L1 instruction cache. Put in an unimplemented-device stub for this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h |  1 +
>  hw/arm/armsse.c         | 39 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
