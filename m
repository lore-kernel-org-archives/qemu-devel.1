Received: from eggs.gnu.org ([2001:4830:134:3::10]:40713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDV2-0000uk-As
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDV1-0003IZ-9n
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:10:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:36109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDV0-0003GE-UA
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:10:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id a8-v6so7670109wmf.1
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:10:27 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-20-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2235e4b-3115-b534-db93-daca0f3fc794@linaro.org>
Date: Sun, 21 Oct 2018 14:10:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-20-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 19/56] xtensa: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/xtensa/cpu.c       | 2 +-
>  target/xtensa/helper.c    | 2 +-
>  target/xtensa/op_helper.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
