Received: from eggs.gnu.org ([209.51.188.92]:45385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goYGY-0007hy-Ox
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goYGX-0004cz-Pd
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:37:46 -0500
Date: Tue, 29 Jan 2019 19:37:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190129193738.60a40309.cohuck@redhat.com>
In-Reply-To: <eecbc9c1-cae8-f5d6-32be-8bf71436ac2f@redhat.com>
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-3-david@redhat.com>
	<20190123120539.3ca367f9.cohuck@redhat.com>
	<20190128122833.4613659a.cohuck@redhat.com>
	<3b9f7e27-5f3b-5a36-87ab-209942334e59@linux.ibm.com>
	<0c546fd4-28dd-6e62-8f9f-cd7894d36849@redhat.com>
	<a904740f-66e5-0956-44e7-4c29a4552897@linux.ibm.com>
	<accf8243-1100-117b-9bae-899537bf433c@redhat.com>
	<f9959c97-463e-9681-46ef-19ea728c2025@linux.ibm.com>
	<eecbc9c1-cae8-f5d6-32be-8bf71436ac2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 2/2] s390x/pci: Unplug
 remaining devices on pcihost reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: pmorel@linux.ibm.com, Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Tue, 29 Jan 2019 19:20:55 +0100
David Hildenbrand <david@redhat.com> wrote:

> Conny could pick up patch #1 once you get an ACK. I would send more
> patches to drop the timer and rework this patch.

Sure, will do.
