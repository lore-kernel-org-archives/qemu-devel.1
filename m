Received: from eggs.gnu.org ([2001:4830:134:3::10]:43502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faPvW-00028N-F1
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faPvT-0005IZ-7y
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:21:22 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:35526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1faPvT-0005H4-0s
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:21:19 -0400
Received: by mail-pl0-x243.google.com with SMTP id k1-v6so1424371plt.2
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 11:21:18 -0700 (PDT)
References: <20180703171044.9503-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <823c2db8-22f1-a7be-1684-a2c012286b25@linaro.org>
Date: Tue, 3 Jul 2018 11:20:56 -0700
MIME-Version: 1.0
In-Reply-To: <20180703171044.9503-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/4] cmsdk-apb-timer: various
 bugfixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, patches@linaro.org

On 07/03/2018 10:10 AM, Peter Maydell wrote:
> Guenter Roeck (1):
>   hw/timer/cmsdk-apb-timer: Correctly identify and set one-shot mode
> 
> Peter Maydell (3):
>   ptimer: Add TRIGGER_ONLY_ON_DECREMENT policy option
>   hw/timer/cmsdk-apb-timer: Correct ptimer policy settings
>   hw/timer/cmsdk-apb-timer: run or stop timer on writes to RELOAD and
>     VALUE

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
