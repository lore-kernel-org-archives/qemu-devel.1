Received: from eggs.gnu.org ([2001:4830:134:3::10]:50597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7ngs-0001kY-N0
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7ngn-0000qq-6K
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:24:13 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:37435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7ngm-0000oK-FV
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:24:08 -0400
Received: by mail-ot1-x331.google.com with SMTP id o13-v6so6908459otl.4
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 13:24:02 -0700 (PDT)
References: <20181003200454.18384-1-cota@braap.org>
	<20181003200454.18384-3-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa1926be-b08a-2470-cf92-1bb14468b35f@linaro.org>
Date: Wed, 3 Oct 2018 15:23:58 -0500
MIME-Version: 1.0
In-Reply-To: <20181003200454.18384-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] cputlb: fix assert_cpu_is_self macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 10/3/18 3:04 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/cputlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
