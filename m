Received: from eggs.gnu.org ([2001:4830:134:3::10]:55824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKnuA-0005Z3-0D
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKnu7-0003F2-Lc
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:15:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKnu7-000309-33
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:15:39 -0500
Received: by mail-wm1-x332.google.com with SMTP id r11-v6so2039928wmb.2
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:15:25 -0800 (PST)
References: <20181108163329.19940-1-alex.bennee@linaro.org>
	<20181108163329.19940-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1fabdfca-32fc-b66d-ba46-eed8fafb4f96@linaro.org>
Date: Thu, 8 Nov 2018 18:15:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181108163329.19940-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] arm: use symbolic MDCR_TDE in
 arm_debug_target_el
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

On 11/8/18 5:33 PM, Alex Bennée wrote:
> We already have this symbol defined so lets use it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
