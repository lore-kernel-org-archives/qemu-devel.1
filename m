Received: from eggs.gnu.org ([2001:4830:134:3::10]:39603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVzNi-0007iQ-Qw
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVzNi-0002Qp-1a
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:35:22 -0500
Date: Tue, 24 Jan 2017 11:35:12 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124113512.GA1516@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] iscsi: Add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, jcody@redhat.com
Cc: qemu-block@nongnu.org, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Thu, Dec 08, 2016 at 02:23:05PM +0100, Kevin Wolf wrote:
> This adds blockdev-add support to the iscsi block driver.
> 
> Note that this is only compile tested at this point. Jeff is going to
> take over from here and bring the series to a mergable state.

I've not seen any updates to this and soft-freeze is fast approaching.

I really badly want to see this fixed in QEMU 2.9 so libvirt can use
it to fix iSCSI authentication support.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
