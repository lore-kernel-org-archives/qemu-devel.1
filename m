Received: from eggs.gnu.org ([209.51.188.92]:45740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9r4-0007J1-QR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9r2-00006y-6R
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:33:50 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9r1-0007zo-TZ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:33:48 -0500
Received: by mail-pl1-x643.google.com with SMTP id u18so7960988plq.7
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 08:33:21 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-24-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d0a8043-42fd-5ea8-44a2-8a27a90fee3a@linaro.org>
Date: Mon, 28 Jan 2019 08:33:17 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/23] hw/arm/mps2-tz: Add mps2-an521 model
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
> Add a model of the MPS2 FPGA image described in Application Note
> AN521. This is identical to the AN505 image, except that it uses
> the SSE-200 rather than the IoTKit and so has two Cortex-M33 CPUs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/mps2-tz.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
