Received: from eggs.gnu.org ([2001:4830:134:3::10]:40266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3l6-0000pi-7C
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3l1-0004LM-Ns
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:10:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:34006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3kw-00044E-Qq
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:10:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id f1-v6so4428737wmg.1
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:10:15 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-38-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <023e2be1-4634-6806-cc02-f01d7c78aadf@linaro.org>
Date: Fri, 26 Oct 2018 16:10:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-38-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 38/71] i386/kvm: convert to
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
>  target/i386/kvm.c | 54 +++++++++++++++++++++++++++--------------------
>  1 file changed, 31 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
