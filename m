Received: from eggs.gnu.org ([2001:4830:134:3::10]:47976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dHbae-0003iH-85
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 15:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dHbad-00073K-5J
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 15:53:32 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dHbac-0006vU-VJ
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 15:53:31 -0400
Date: Sun, 4 Jun 2017 21:53:15 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170604195315.6c5az3vp5jh53y4g@aurel32.net>
References: <20170604173509.29684-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PULL 00/69] target/s390x tcg patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 2017-06-04 10:34, Richard Henderson wrote:
> The queue has gotten overlong.  This includes my unwinding patches,
> the execute rewrite, and Aurelien's flushing out of missing Z insns.
> 
> It does *not* include Aurelian's final patch to bump the base tcg
> cpu to z800.  David Hildenbrand had objections to that; I expect
> that we can address that in the next patch set.

Fair enough. I think I'll put this one in standby and look at that again
when QEMU can emulate a higher model like a z990.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
