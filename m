Received: from eggs.gnu.org ([2001:4830:134:3::10]:36644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3aP-0007Fp-ME
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3aM-0005tW-40
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:59:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:53801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3aK-0005sO-2T
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:59:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id l26-v6so1818889wmh.3
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 07:59:35 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-11-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <54a163f1-8060-61aa-5af1-1c5e5041f3b4@linaro.org>
Date: Fri, 26 Oct 2018 15:59:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-11-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 11/71] m68k: convert to
 helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>

On 10/25/18 3:45 PM, Emilio G. Cota wrote:
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/m68k/translate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
