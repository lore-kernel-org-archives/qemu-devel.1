Received: from eggs.gnu.org ([2001:4830:134:3::10]:46761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDrX-0002p4-5X
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDrW-0001Ka-IN
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:33:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDrW-0001KE-Aw
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:33:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id a8-v6so7701341wmf.1
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:33:46 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-46-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2a46b6b3-b012-348b-f845-641f6bca68f2@linaro.org>
Date: Sun, 21 Oct 2018 14:33:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-46-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 45/56] microblaze: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/microblaze/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
