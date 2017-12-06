Received: from eggs.gnu.org ([2001:4830:134:3::10]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMVYv-0005uE-BG
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMVYp-0006HU-OE
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:00:17 -0500
Date: Wed, 6 Dec 2017 10:00:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171206100005.31142cc5.cohuck@redhat.com>
In-Reply-To: <27f5a0c3-755a-bd1b-11b5-d7a73808d1de@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-3-pasic@linux.vnet.ibm.com>
	<20171204121511.0abe9ca2.cohuck@redhat.com>
	<f237126d-0815-8433-6ef7-1c1ba2e5a956@linux.vnet.ibm.com>
	<27f5a0c3-755a-bd1b-11b5-d7a73808d1de@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/css: advertise unrestricted
 cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

On Tue, 5 Dec 2017 18:28:47 +0100
Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com> wrote:

> On 12/04/2017 04:07 PM, Halil Pasic wrote:
> >
> > On 12/04/2017 12:15 PM, Cornelia Huck wrote:  

> >> Looks reasonable. If this works as expected, I'll squash it into the
> >> previous patch.
> >>  
> > I've just asked Shalini to verify the libvirt perspective.  
> 
> Verified. The patch works as expected.

Cool, thanks! It seems we have a winner here.
