Received: from eggs.gnu.org ([2001:4830:134:3::10]:52979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWP6t-0000Df-Fg
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWP6s-0002rN-Na
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:08:15 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:44823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWP6s-0002qV-HX
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:08:14 -0500
Received: by mail-pl0-x244.google.com with SMTP id n13so28906892plp.11
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:08:14 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-5-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <11b31db2-71ae-54ef-6368-a7da823534bf@linaro.org>
Date: Tue, 2 Jan 2018 08:08:10 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 04/17] target-m68k: use insn_pc to
 generate instruction fault address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/01/2018 05:10 PM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
