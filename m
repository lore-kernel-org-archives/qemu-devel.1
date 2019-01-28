Received: from eggs.gnu.org ([209.51.188.92]:44159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9lr-000368-7a
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9lq-0002nt-IQ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:28:27 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9lq-0002jv-6R
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:28:26 -0500
Received: by mail-pl1-x644.google.com with SMTP id e5so7961711plb.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 08:28:24 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-22-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <69a854f8-c52d-20f9-ddee-0c1d751b32dc@linaro.org>
Date: Mon, 28 Jan 2019 08:28:19 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/23] hw/arm/armsse: Add SSE-200 model
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
> Add a model of the SSE-200, now we have put in all
> the code that lets us make it different from the IoTKit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h | 19 ++++++++++++++++---
>  hw/arm/armsse.c         | 12 ++++++++++++
>  2 files changed, 28 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
