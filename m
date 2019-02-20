Received: from eggs.gnu.org ([209.51.188.92]:35969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwV9Q-00034v-3s
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwV9P-0004Gw-BW
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:55:16 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:42364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwV9O-0004FP-QN
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:55:15 -0500
Received: by mail-pl1-x62b.google.com with SMTP id s1so12493862plp.9
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 08:55:14 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-61-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b5d5dcfd-7468-db8e-eb96-e5670ac814ac@linaro.org>
Date: Wed, 20 Feb 2019 08:55:10 -0800
MIME-Version: 1.0
In-Reply-To: <20190130004811.27372-61-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 60/73] cpu: convert to interrupt_request
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

On 1/29/19 4:47 PM, Emilio G. Cota wrote:
> This finishes the conversion to interrupt_request.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  qom/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
