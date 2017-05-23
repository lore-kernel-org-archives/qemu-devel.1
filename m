Received: from eggs.gnu.org ([2001:4830:134:3::10]:38297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7Qe-00065I-Q2
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7Qd-0001bw-Vz
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:52:40 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dD7Qd-0001bg-Q1
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:52:39 -0400
Date: Tue, 23 May 2017 12:52:37 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170523105237.vekbbtniax5lj23w@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-8-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170523030312.6360-8-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 07/31] target/s390x: Use unwind data for
 helper_clc
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

On 2017-05-22 20:02, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 18 +++++++++---------
>  target/s390x/translate.c  |  1 -
>  2 files changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
