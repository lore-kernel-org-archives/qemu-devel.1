Received: from eggs.gnu.org ([2001:4830:134:3::10]:46530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzHh-0002LQ-NY
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzHg-0002Tt-PV
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:23:01 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:36988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzHg-0002Qk-JK
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:23:00 -0400
Date: Thu, 25 May 2017 22:22:44 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170525202244.uxba3rwosy5ouemh@aurel32.net>
References: <20170524192246.15905-1-rth@twiddle.net>
	<20170524192246.15905-3-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524192246.15905-3-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 02/33] target/s390x: Move helper_ex to
 end of file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 2017-05-24 12:22, Richard Henderson wrote:
> This will avoid needing forward declarations in following patches.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 161 +++++++++++++++++++++++-----------------------
>  1 file changed, 81 insertions(+), 80 deletions(-)
> 

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
