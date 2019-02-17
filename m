Received: from eggs.gnu.org ([209.51.188.92]:56764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvR3m-0007JW-P0
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvR3k-0001zD-N4
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:21:02 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:46290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvR3i-0001uo-Lw
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:21:00 -0500
Received: by mail-pl1-x62f.google.com with SMTP id o6so7559840pls.13
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 10:20:56 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f08dc682-0c3e-bb23-b746-760121a70f0f@linaro.org>
Date: Sun, 17 Feb 2019 10:20:52 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/14] hw/arm/musca: Wire up PL011 UARTs
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
> Wire up the two PL011 UARTs in the Musca board.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/musca.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
