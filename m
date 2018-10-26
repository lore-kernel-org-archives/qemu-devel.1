Received: from eggs.gnu.org ([2001:4830:134:3::10]:50276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4J2-0004cv-J6
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Iz-0002dI-9j
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:45:48 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:36851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4Ix-0002UA-I4
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:45:45 -0400
Received: by mail-pf1-x433.google.com with SMTP id l81-v6so754863pfg.3
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:45:41 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-48-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7f66b74b-ad2b-f1c8-608a-b3c0c2fa6872@linaro.org>
Date: Fri, 26 Oct 2018 16:45:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-48-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 48/71] mips: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, James Hogan <jhogan@kernel.org>

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: James Hogan <jhogan@kernel.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/mips/cpu.c | 7 ++++---
>  target/mips/kvm.c | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
