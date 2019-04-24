Received: from eggs.gnu.org ([209.51.188.92]:59764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7kw-00015Y-1H
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7bk-0004Cr-1v
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:26:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:46201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ7bj-0004Bo-RL
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:25:59 -0400
Received: by mail-pl1-x636.google.com with SMTP id o7so6219647pll.13
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 19:25:59 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-27-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <225678d1-5bf1-d210-642b-c5040f12104c@linaro.org>
Date: Tue, 23 Apr 2019 19:25:55 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-27-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 26/26] target/arm: Enable FPU for Cortex-M4
 and Cortex-M33
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Enable the FPU by default for the Cortex-M4 and Cortex-M33.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
