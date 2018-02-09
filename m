Received: from eggs.gnu.org ([2001:4830:134:3::10]:58631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekCy3-000470-KY
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekCy0-0004bl-L3
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:00:11 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:46755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekCy0-0004b6-GV
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:00:08 -0500
Received: by mail-io0-x241.google.com with SMTP id f34so10534787ioi.13
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 10:00:08 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-26-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e177fb2d-36d7-a835-2c1f-59e90a708e80@linaro.org>
Date: Fri, 9 Feb 2018 10:00:04 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-26-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 25/32] arm/translate-a64: add FP16 FRCPX
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
> We go with the localised helper.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/helper-a64.c    | 29 +++++++++++++++++++++++++++++
>  target/arm/helper-a64.h    |  1 +
>  target/arm/translate-a64.c |  4 ++++
>  3 files changed, 34 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
