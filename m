Received: from eggs.gnu.org ([2001:4830:134:3::10]:37596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3ck-0000bW-FZ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3ch-0007F8-9m
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:02:06 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:38453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3ch-0007EP-2v
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:02:03 -0400
Received: by mail-wr1-x432.google.com with SMTP id d10-v6so1698986wrs.5
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:02:02 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-15-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1bb218f0-0eba-2c29-202c-4bac9cc839c1@linaro.org>
Date: Fri, 26 Oct 2018 16:01:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-15-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 15/71] tcg-runtime: convert to
 cpu_halted_set
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

On 10/25/18 3:45 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/tcg-runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
