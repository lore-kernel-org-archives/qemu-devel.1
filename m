Received: from eggs.gnu.org ([2001:4830:134:3::10]:44275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dn2e4-0007FX-Br
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dn2e1-0001ze-7u
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dn2e1-0001zL-1t
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:02:57 -0400
Date: Wed, 30 Aug 2017 16:02:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170830155528-mutt-send-email-mst@kernel.org>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170824192730.8440-2-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 01/32] vhu: vu_queue_started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, marcandre.lureau@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

> Subject: Re: [RFC v2 01/32] vhu: vu_queue_started

I mean, how did we end up with "vhu"? I never meant that to happen :(
It's merely in the commit title but maybe we can come up with a
better-sounding way to abbreviate vhost user.

-- 
MST
