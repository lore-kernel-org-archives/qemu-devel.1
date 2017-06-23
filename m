Received: from eggs.gnu.org ([2001:4830:134:3::10]:38099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOMIm-0004IZ-1K
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOMIl-0004Hy-2t
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:59:00 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dOMIk-0004Hk-Sh
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:58:59 -0400
Date: Fri, 23 Jun 2017 12:58:55 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170623105855.pedudacuy7amevtd@aurel32.net>
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-2-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620000405.3391-2-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 01/18] target/s390x: Map existing FAC_*
 names to S390_FEAT_* names
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

On 2017-06-19 17:03, Richard Henderson wrote:
> The FAC_ names were placeholders prior to the introduction
> of the current facility modeling.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/translate.c | 59 ++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
