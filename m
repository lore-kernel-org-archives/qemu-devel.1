Received: from eggs.gnu.org ([2001:4830:134:3::10]:53967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmb9V-0001gJ-Ir
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 03:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmb9T-0008RH-3F
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 03:41:37 -0400
Date: Tue, 29 Aug 2017 09:41:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170829094130.23212151.cohuck@redhat.com>
In-Reply-To: <0413bb07-bd76-20fc-f29c-9b0bd60efd1d@redhat.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<0413bb07-bd76-20fc-f29c-9b0bd60efd1d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/79] Patch Round-up for stable 2.9.1,
 freeze on 2017-09-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Tue, 29 Aug 2017 04:18:20 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 29.08.2017 02:13, Michael Roth wrote:
> > Hi everyone,
> > 
> > The following new patches are queued for QEMU stable v2.9.1:
> > 
> >   https://github.com/mdroth/qemu/commits/stable-2.9-staging
> > 
> > The release is planned for 2017-09-07:
> > 
> >   http://wiki.qemu.org/Planning/2.9
> > 
> > Please respond here or CC qemu-stable@nongnu.org on any patches you
> > think should be included in the release.  
> 
> I'd like to suggest the following patches:
> 
> 601b9a9008c5a612d76073bb - target-s390x: Mask the SIGP order_code ...

> 99efaa2696caaf6182958e27 - hw/s390x/ipl: Fix crash with ...

Agreed on the s390x patches.
