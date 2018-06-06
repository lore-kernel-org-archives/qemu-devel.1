Received: from eggs.gnu.org ([2001:4830:134:3::10]:48648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQZTU-0001Js-3z
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQZTQ-0001Zo-UD
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:31:44 -0400
Date: Wed, 6 Jun 2018 17:31:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180606173039-mutt-send-email-mst@kernel.org>
References: <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606114035.GG1455@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606114035.GG1455@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org

On Wed, Jun 06, 2018 at 12:40:35PM +0100, Richard W.M. Jones wrote:
> I started off a long reply here, but I think you're right.  If we
> cannot make people decide on and use a proper disk image + metadata
> container, then it's also unlikely we'll get them to add sensible
> metadata to their qcow2 images either :-(
> 
> Rich.

But we can do it for them: ask how to run image, store it
in the image forever.

-- 
MST
