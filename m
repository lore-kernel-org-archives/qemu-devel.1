Received: from eggs.gnu.org ([209.51.188.92]:52030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goV3D-0005r3-MX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goV2y-0006lv-28
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:11:41 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goV2w-0006hu-IN
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:11:32 -0500
Received: by mail-oi1-x241.google.com with SMTP id w13so16358482oiw.9
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 07:11:24 -0800 (PST)
References: <20190129140411.682-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <709b14af-3671-6fed-c8a8-55e1651467b5@linaro.org>
Date: Tue, 29 Jan 2019 07:11:13 -0800
MIME-Version: 1.0
In-Reply-To: <20190129140411.682-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: Fix FCMLA decoding errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>

On 1/29/19 6:04 AM, Peter Maydell wrote:
> Peter Maydell (2):
>   target/arm/translate-a64: Fix FCMLA decoding error
>   target/arm/translate-a64: Fix mishandling of size in FCMLA decode
> 
>  target/arm/translate-a64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
