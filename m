Received: from eggs.gnu.org ([2001:4830:134:3::10]:40903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3n6-0002uV-5C
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3mz-0005vL-45
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:12:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:53888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3my-0005P9-JK
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:12:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id l26-v6so1859584wmh.3
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:12:24 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-40-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0310c143-6967-c568-67a2-5d28af5d1a58@linaro.org>
Date: Fri, 26 Oct 2018 16:12:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-40-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 40/71] i386/whpx-all: convert to
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
>  target/i386/whpx-all.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
