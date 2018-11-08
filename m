Received: from eggs.gnu.org ([2001:4830:134:3::10]:51865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKgUG-0006kY-Ls
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:20:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKgUB-0008EM-QX
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:20:27 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKgUB-00083N-CM
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:20:23 -0500
Received: by mail-wr1-x443.google.com with SMTP id i17-v6so20395117wre.7
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 01:20:13 -0800 (PST)
References: <20181106164118.16184-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <caaa4dfc-f104-96b7-c221-1dc0f95f7112@linaro.org>
Date: Thu, 8 Nov 2018 10:20:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181106164118.16184-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] target/arm: Remove antique TODO
 comment
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

On 11/6/18 5:41 PM, Peter Maydell wrote:
> Remove a TODO comment about implementing the vectored interrupt
> controller. We have had an implementation of that for a decade;
> it's in hw/intc/pl190.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
