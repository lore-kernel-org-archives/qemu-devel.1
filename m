Received: from eggs.gnu.org ([209.51.188.92]:56580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvR2z-0006qx-VM
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvR2z-0000JB-AN
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:20:13 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:44581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvR2z-0000IR-2M
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:20:13 -0500
Received: by mail-pg1-x52a.google.com with SMTP id y1so7268087pgk.11
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 10:20:12 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <63b1b4ef-4f2f-f9f1-15e3-7d13f73dc695@linaro.org>
Date: Sun, 17 Feb 2019 10:20:09 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/14] hw/arm/musca: Wire up PL031 RTC
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

On 2/14/19 4:51 AM, Peter Maydell wrote:
> Wire up the PL031 RTC for the Musca board.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/musca.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
