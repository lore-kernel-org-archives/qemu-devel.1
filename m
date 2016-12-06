Received: from eggs.gnu.org ([2001:4830:134:3::10]:53037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cED14-00045z-Sg
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cED11-0008J6-4f
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:30:30 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <35E2FCDC-462E-4EC2-940E-B37247C69E24@alex.org.uk>
Date: Tue, 6 Dec 2016 10:30:24 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <9433A8E5-1A27-460D-9842-B8A4EBFC462F@alex.org.uk>
References: <20161205234235.5728-1-eblake@redhat.com>
	<35E2FCDC-462E-4EC2-940E-B37247C69E24@alex.org.uk>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] doc: Propose NBD_FLAG_INIT_ZEROES
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, xieyingtai@huawei.com, subo7@huawei.com, qemu block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


> On 6 Dec 2016, at 08:46, Alex Bligh <alex@alex.org.uk> wrote:
> 
> I would support this.
> 
> In fact the patch is sufficiently simple I think I'd merge this
> into extension-write-zeroes then merge that into master.

Hence:

Reviewed-By: Alex Bligh <alex@alex.org.uk>

-- 
Alex Bligh
