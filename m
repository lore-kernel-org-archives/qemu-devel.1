Received: from eggs.gnu.org ([2001:4830:134:3::10]:54218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqm9l-0006vF-5m
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqm9g-0005PA-88
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:47:25 -0500
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:42165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqm9g-0005P3-1o
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:47:20 -0500
Received: by mail-pf0-x22b.google.com with SMTP id a16so63826pfn.9
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 12:47:19 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f0430656-7384-2177-9d0c-37bcb7af771a@linaro.org>
Date: Tue, 27 Feb 2018 12:47:16 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/19] target/arm: Add Cortex-M33
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

On 02/20/2018 10:03 AM, Peter Maydell wrote:
> Add a Cortex-M33 definition. The M33 is an M profile CPU
> which implements the ARM v8M architecture, including the
> M profile Security Extension.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
