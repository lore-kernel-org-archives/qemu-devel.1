Received: from eggs.gnu.org ([2001:4830:134:3::10]:40232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ1zw-0001oL-9I
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ1zs-0005Z3-Ba
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:08:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZ1zs-0005Yg-53
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:08:24 -0500
Date: Mon, 17 Dec 2018 18:08:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181217180801-mutt-send-email-mst@kernel.org>
References: <20181214131043.25071-1-david@redhat.com>
	<20181217102841-mutt-send-email-mst@kernel.org>
	<20181217230624.GM7141@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217230624.GM7141@habkost.net>
Subject: Re: [Qemu-devel] [PATCH v5 0/2] range/memory-device: fixes and
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Dec 17, 2018 at 09:06:24PM -0200, Eduardo Habkost wrote:
> On Mon, Dec 17, 2018 at 10:28:58AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Dec 14, 2018 at 02:10:41PM +0100, David Hildenbrand wrote:
> > > These are the two leftovers from
> > >     [PATCH v3 0/7] qapi/range/memory-device: fixes and cleanups
> > 
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Who's merging this Eduardo?
> 
> As I have merged memory-device cleanups before, I can merge it,
> despite MAINTAINERS listing hw/mem/* as part of the ACPI/SMBIOS
> section.  What do you prefer?

Pls go ahead.

> -- 
> Eduardo
