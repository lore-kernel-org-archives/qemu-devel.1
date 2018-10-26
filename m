Received: from eggs.gnu.org ([2001:4830:134:3::10]:40985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3nF-0003Vr-Td
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3nC-000668-AC
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:12:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3nA-00064u-8N
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:12:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 189-v6so1865362wmw.2
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:12:52 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-41-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <419d57c2-ee3a-febe-d575-cc71cf9256b8@linaro.org>
Date: Fri, 26 Oct 2018 16:12:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-41-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 41/71] i386/hvf: convert to
 cpu_request_interrupt
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
>  target/i386/hvf/hvf.c    |  8 +++++---
>  target/i386/hvf/x86hvf.c | 26 +++++++++++++++-----------
>  2 files changed, 20 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
