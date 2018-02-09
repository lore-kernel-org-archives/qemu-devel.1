Received: from eggs.gnu.org ([2001:4830:134:3::10]:59202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekCzD-000587-Ey
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekCz8-0005hw-2G
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:01:23 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:45119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekCz7-0005hU-Tl
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:01:17 -0500
Received: by mail-io0-x242.google.com with SMTP id p188so10529794ioe.12
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 10:01:17 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-27-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f9655d2c-e9d5-4a5b-f3eb-3ec4e9b59594@linaro.org>
Date: Fri, 9 Feb 2018 10:01:13 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-27-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 26/32] arm/translate-a64: add FP16 FSQRT
 to simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   remove superfluous helpers
> ---
>  target/arm/helper-a64.c    | 13 +++++++++++++
>  target/arm/helper-a64.h    |  1 +
>  target/arm/translate-a64.c |  5 +++++
>  3 files changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
