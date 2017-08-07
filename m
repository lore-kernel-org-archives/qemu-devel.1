Received: from eggs.gnu.org ([2001:4830:134:3::10]:51211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dedYK-0003qN-Nk
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dedYG-0005LJ-J6
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:38:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dedYG-0005Kt-CX
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:38:16 -0400
Date: Mon, 7 Aug 2017 09:38:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170807083807.GD18259@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.14d7e60ae019b1418a70bacc4e7d240fadf9c96c.1501362828.git-series.knut.omang@oracle.com>
	<bd078365e3e6f990b8e436ed77b14daf3d26675c.1501362828.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd078365e3e6f990b8e436ed77b14daf3d26675c.1501362828.git-series.knut.omang@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v6 3/4] sockets: factor out
 create_fast_reuse_socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Sat, Jul 29, 2017 at 11:18:17PM +0200, Knut Omang wrote:
> Another refactoring step to prepare for fixing the problem
> exposed with the test-listen test in the previous commit
> 
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  util/qemu-sockets.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
