Received: from eggs.gnu.org ([2001:4830:134:3::10]:36314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3ZI-0005ix-DY
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3ZF-0005Wy-8m
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:58:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3ZE-0005U1-F0
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:58:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id y15-v6so1667357wru.9
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 07:58:26 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-9-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5e2c1adf-c7bc-e335-7e2b-ddd26b1ac158@linaro.org>
Date: Fri, 26 Oct 2018 15:58:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-9-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 09/71] cris: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 10/25/18 3:45 PM, Emilio G. Cota wrote:
> And fix the temp leak along the way.
> 
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/cris/translate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
