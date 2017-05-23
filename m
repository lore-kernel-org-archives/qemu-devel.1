Received: from eggs.gnu.org ([2001:4830:134:3::10]:43649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7kQ-00079q-Ao
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7kP-0002ck-Ck
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:06 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dD7kP-0002c5-6s
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:05 -0400
Date: Tue, 23 May 2017 13:13:03 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170523111303.hbhzl3fldjfy7635@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-32-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170523030312.6360-32-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 31/31] target/s390x: Use unwind data for
 helper_mvcs/mvcp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-22 20:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 8 ++++++--
>  target/s390x/translate.c  | 2 --
>  2 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
