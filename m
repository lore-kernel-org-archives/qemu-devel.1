Received: from eggs.gnu.org ([2001:4830:134:3::10]:39636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3jU-0007OO-DS
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3jR-0003J4-S8
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:09:04 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:40968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3jR-0003Ip-Ku
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:09:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id x12-v6so1705302wrw.8
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:09:01 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-37-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d1859555-16ac-2091-dba6-e17e7aebf24b@linaro.org>
Date: Fri, 26 Oct 2018 16:08:57 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-37-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 37/71] i386: convert to
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
>  target/i386/cpu.c        | 2 +-
>  target/i386/helper.c     | 4 ++--
>  target/i386/svm_helper.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
