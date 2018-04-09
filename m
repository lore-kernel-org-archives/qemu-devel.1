Received: from eggs.gnu.org ([2001:4830:134:3::10]:57426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f5XOo-0007yR-3Z
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f5XOn-0000dk-92
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:03:58 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:35662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f5XOm-0000dH-U8
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:03:57 -0400
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-16-git-send-email-cota@braap.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <79942a01-1612-3745-863f-e02836b7ad2a@mail.uni-paderborn.de>
Date: Mon, 9 Apr 2018 16:03:54 +0200
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-16-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/17] target/riscv: convert to
 DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>

On 04/06/2018 08:19 PM, Emilio G. Cota wrote:
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/riscv/translate.c | 72 +++++++++++++++++++-----------------------------
>  1 file changed, 28 insertions(+), 44 deletions(-)
> 

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
