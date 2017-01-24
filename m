Received: from eggs.gnu.org ([2001:4830:134:3::10]:52068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cW1UU-00025G-Ct
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cW1UT-0008Ox-KE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:50:30 -0500
Date: Tue, 24 Jan 2017 08:50:21 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170124135021.GA11609@localhost.localdomain>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
	<20170124113512.GA1516@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170124113512.GA1516@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] iscsi: Add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Tue, Jan 24, 2017 at 11:35:12AM +0000, Daniel P. Berrange wrote:
> On Thu, Dec 08, 2016 at 02:23:05PM +0100, Kevin Wolf wrote:
> > This adds blockdev-add support to the iscsi block driver.
> > 
> > Note that this is only compile tested at this point. Jeff is going to
> > take over from here and bring the series to a mergable state.
> 
> I've not seen any updates to this and soft-freeze is fast approaching.
> 
> I really badly want to see this fixed in QEMU 2.9 so libvirt can use
> it to fix iSCSI authentication support.
> 
> Regards,
> Daniel

Hi Daniel,

Yep, I am working on getting the patches out.  It should be out soon.

Jeff
