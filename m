Received: from eggs.gnu.org ([2001:4830:134:3::10]:47814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dn2ot-0003d2-Mn
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dn2oo-0007ff-Jh
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:14:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dn2oo-0007fT-Du
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:14:06 -0400
Date: Wed, 30 Aug 2017 09:13:56 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <2139507594.6080508.1504098836285.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170830155528-mutt-send-email-mst@kernel.org>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-2-dgilbert@redhat.com>
	<20170830155528-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 01/32] vhu: vu_queue_started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, maxime coquelin <maxime.coquelin@redhat.com>, a perevalov <a.perevalov@samsung.com>, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

Hi

----- Original Message -----
> > Subject: Re: [RFC v2 01/32] vhu: vu_queue_started
> 
> I mean, how did we end up with "vhu"? I never meant that to happen :(
> It's merely in the commit title but maybe we can come up with a
> better-sounding way to abbreviate vhost user.

vhu, no idea :)

I would suggest to use libvhost-user: prefix in commit messages for contrib/libvhost-user changes.

vhost-user: for qemu vhost-user changes.

vhost-user-bridge: (or vub:), vhost-user-scsi: (or vus:)  for those backends.
