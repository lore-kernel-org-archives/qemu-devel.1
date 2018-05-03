Received: from eggs.gnu.org ([2001:4830:134:3::10]:50831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIkc-0006jy-D8
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIkY-0004yK-Tr
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:14:42 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEIkY-0004xx-OE
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:14:38 -0400
Received: by mail-pg0-x244.google.com with SMTP id g20-v6so7008100pgv.1
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:14:38 -0700 (PDT)
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-13-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <85d42e7f-2664-d2e7-2a97-e3f771e29505@linaro.org>
Date: Thu, 3 May 2018 11:14:35 -0700
MIME-Version: 1.0
In-Reply-To: <20180503091922.28733-13-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 12/29] target-microblaze: Remove pointer
 indirection for ld/st addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

On 05/03/2018 02:19 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Heh, right-o.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
