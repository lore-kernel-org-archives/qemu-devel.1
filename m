Received: from eggs.gnu.org ([2001:4830:134:3::10]:37440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7NX-0003XK-U8
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7NX-0000JJ-6q
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:49:27 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dD7NX-0000Iz-1O
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:49:27 -0400
Date: Tue, 23 May 2017 12:49:23 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170523104923.7sm5svfu3seht4gj@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-4-rth@twiddle.net>
	<2e84d9b1-4b28-9300-c909-cba2100d2be3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e84d9b1-4b28-9300-c909-cba2100d2be3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/31] target/s390x: Use unwind data for
 helper_nc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 2017-05-23 10:33, Thomas Huth wrote:
> On 23.05.2017 05:02, Richard Henderson wrote:
> > Signed-off-by: Richard Henderson <rth@twiddle.net>
> > ---
> >  target/s390x/mem_helper.c | 18 +++++++++---------
> >  target/s390x/translate.c  |  1 -
> >  2 files changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
