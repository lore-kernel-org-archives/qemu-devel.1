Received: from eggs.gnu.org ([2001:4830:134:3::10]:49937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f73IO-0001BI-Hi
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f73IN-0002n3-Ou
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:36 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:41394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f73IN-0002mr-IM
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:35 -0400
Received: by mail-pl0-x242.google.com with SMTP id bj1-v6so6515947plb.8
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 11:19:35 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-18-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <18c19b88-b643-f029-013f-aa1e97e1cfc0@linaro.org>
Date: Thu, 12 Apr 2018 18:40:58 -1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-18-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/17] target/riscv: convert to
 TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 04/06/2018 08:20 AM, Emilio G. Cota wrote:
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/riscv/translate.c | 158 ++++++++++++++++++++++++-----------------------
>  1 file changed, 80 insertions(+), 78 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
