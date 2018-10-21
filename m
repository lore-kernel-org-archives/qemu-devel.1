Received: from eggs.gnu.org ([2001:4830:134:3::10]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDPh-0004B7-FN
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDNI-0005dt-MI
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:02:35 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDNI-0005co-FF
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:02:32 -0400
Received: by mail-wr1-x436.google.com with SMTP id t10-v6so408110wrn.10
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:02:32 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-16-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <85bc615e-5ed1-9acd-f467-4612577de8e9@linaro.org>
Date: Sun, 21 Oct 2018 14:02:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-16-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 15/56] mips: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, James Hogan <jhogan@kernel.org>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: James Hogan <jhogan@kernel.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/mips/cps.c           | 2 +-
>  hw/misc/mips_itu.c      | 4 ++--
>  target/mips/kvm.c       | 2 +-
>  target/mips/op_helper.c | 8 ++++----
>  target/mips/translate.c | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
