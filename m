Received: from eggs.gnu.org ([2001:4830:134:3::10]:57749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqKP-0005LI-7e
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqKM-00006W-Gw
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:11:13 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fsqKM-00006C-9B
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:11:10 -0400
Received: by mail-pg1-x542.google.com with SMTP id h17-v6so2625577pgv.3
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 07:11:10 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <01b9ce29-9bbb-983f-99bd-4414916625fe@linaro.org>
Date: Thu, 23 Aug 2018 07:11:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/22] hw/arm/mps2: Wire up dual-timer in
 mps2-an385 and mps2-an511
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, patches@linaro.org

On 08/20/2018 07:10 AM, Peter Maydell wrote:
> The MPS2 FPGA images for the Cortex-M3 (mps2-an385 and mps2-511)
> both include a CMSDK dual-timer module. Wire this up.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/mps2.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
