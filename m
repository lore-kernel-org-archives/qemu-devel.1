Received: from eggs.gnu.org ([2001:4830:134:3::10]:51996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4LO-0006lr-A3
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4LL-0005Q0-4L
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:48:14 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:43266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4LK-0005Os-N7
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:48:11 -0400
Received: by mail-pg1-x532.google.com with SMTP id n10-v6so713172pgv.10
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:48:10 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-57-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bf57bb53-d388-eee8-e233-f2812b0141b4@linaro.org>
Date: Fri, 26 Oct 2018 16:48:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-57-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 57/71] accel/tcg: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/cpu-exec.c      | 15 ++++++++-------
>  accel/tcg/tcg-all.c       | 12 +++++++++---
>  accel/tcg/translate-all.c |  2 +-
>  3 files changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
