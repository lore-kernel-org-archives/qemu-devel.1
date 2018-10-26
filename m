Received: from eggs.gnu.org ([2001:4830:134:3::10]:37162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3by-0008U1-Dd
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3bu-0006eF-B2
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:01:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3bs-0006OR-VV
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:01:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id y144-v6so1735559wmd.4
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:00:51 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-13-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2e6d9204-5c0a-c2dd-6701-8a80a4382d4b@linaro.org>
Date: Fri, 26 Oct 2018 16:00:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-13-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 13/71] microblaze: convert to
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
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/microblaze/translate.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
