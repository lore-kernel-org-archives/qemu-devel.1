Received: from eggs.gnu.org ([2001:4830:134:3::10]:46685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eBb90-00044H-Tt
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eBb8z-000789-QY
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:44:26 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:49248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1eBb8z-0006rR-KR
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:44:25 -0500
Date: Mon, 6 Nov 2017 07:44:09 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20171106064409.u46jexf5cafghlmw@aurel32.net>
References: <1509929837-178178-1-git-send-email-jiang.biao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509929837-178178-1-git-send-email-jiang.biao2@zte.com.cn>
Sender: Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PATCH] tcg/mips: remove inline keywords.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: rth@twiddle.net, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn

On 2017-11-06 08:57, Jiang Biao wrote:
> The compiler will make reasonable default choies for inline
> functions, so the inline keywords are redundant. Remove them to
> retain consistant code style.
> 
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
> Suggested-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/mips/tcg-target.inc.c | 52 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

Looks good to me.

Acked-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
