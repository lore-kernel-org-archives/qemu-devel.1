Received: from eggs.gnu.org ([2001:4830:134:3::10]:36856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3ax-0007gQ-9L
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3aw-000680-GZ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:00:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3aw-00067k-9d
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:00:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id n5-v6so1658749wrw.12
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:00:14 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-12-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ac322daa-4091-5ea2-84ac-f98f826b792f@linaro.org>
Date: Fri, 26 Oct 2018 16:00:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-12-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 12/71] alpha: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/25/18 3:45 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/alpha/translate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
