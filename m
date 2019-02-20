Received: from eggs.gnu.org ([209.51.188.92]:51433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwUdH-00079A-BE
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwUdG-0006XM-Au
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:22:03 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:41174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwUdF-00069s-Q3
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:22:02 -0500
Received: by mail-pf1-x42e.google.com with SMTP id d25so3788906pfn.8
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 08:21:24 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-32-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3c7bc8fc-b4a1-7771-5a2b-4f3f8fe8c742@linaro.org>
Date: Wed, 20 Feb 2019 08:21:20 -0800
MIME-Version: 1.0
In-Reply-To: <20190130004811.27372-32-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 31/73] cpu: convert to cpu_halted
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
> This finishes the conversion to cpu_halted.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  cpus.c    | 8 ++++----
>  qom/cpu.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
