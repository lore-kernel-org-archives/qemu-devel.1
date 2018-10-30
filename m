Received: from eggs.gnu.org ([2001:4830:134:3::10]:60596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gHXI8-00017A-Fl
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gHXI3-0007Sz-Hp
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:54:56 -0400
Date: Tue, 30 Oct 2018 17:54:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181030175427.20dc6f2e.cohuck@redhat.com>
In-Reply-To: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
References: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] MAINTAINERS: s390: several updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>

On Mon, 29 Oct 2018 16:42:21 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> I discussed the following maintainer updates at the kvm forum with
> Conny. This is the first set of changes.
> Can the affected persons please Ack the relevant patches?

Thank you to all of the folks agreeing to help with this!

> 
> PS: Alex, do you still want to be listed?
> 
> Christian Borntraeger (4):
>   MAINTAINERS: s390: more maintainers for vfio-ccw
>   MAINTAINERS: s390/virtio-ccw: drop Christian add Halil
>   MAINTAINERS: s390/pci: add Collin Walling as maintainer for zpci
>   MAINTAINERS: s390/boot: the ipl code and the bios belong together
> 
>  MAINTAINERS | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

I'm holding off on patch 4 (waiting for Thomas' ack when he's online
again), but patches 1-3 are now queued to s390-next.
