Received: from eggs.gnu.org ([2001:4830:134:3::10]:56226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEzUe-0001f8-IF
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEzUd-0005xT-OE
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:16:16 -0500
Date: Thu, 8 Dec 2016 14:16:00 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161208141600.GM26641@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
	<1481203391-9523-4-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481203391-9523-4-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/6] iscsi: Add initiator-name option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Thu, Dec 08, 2016 at 02:23:08PM +0100, Kevin Wolf wrote:
> This was previously only available with -iscsi. Again, after this patch,
> the -iscsi option only takes effect if an URL is given. New users are
> supposed to use the new driver-specific option.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/iscsi.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
