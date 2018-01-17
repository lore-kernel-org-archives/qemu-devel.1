Received: from eggs.gnu.org ([2001:4830:134:3::10]:44810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ebqai-0002Vz-EM
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ebqad-0002Em-Dj
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:29:32 -0500
Date: Wed, 17 Jan 2018 17:28:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180117172823.10460f51.cohuck@redhat.com>
In-Reply-To: <2a6eb56a-5bde-6520-d282-269a176254e2@de.ibm.com>
References: <20180117141849.65757-1-borntraeger@de.ibm.com>
	<20180117141849.65757-3-borntraeger@de.ibm.com>
	<20180117153727.2552d1a2.cohuck@redhat.com>
	<94c656aa-4c1d-5297-8e3a-2816c3628290@redhat.com>
	<34233d9f-2a81-3e81-8ea1-c8f11ccb29bc@de.ibm.com>
	<66733c96-819a-c1ef-fada-42057324d224@redhat.com>
	<2a6eb56a-5bde-6520-d282-269a176254e2@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On Wed, 17 Jan 2018 17:04:05 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> I will spin up a second patch that enables stfle81 and name it "ppa15".
> We can then discuss patch 3 on the slow path with enough time to think
> about this.

Sounds good to me. I really don't want to rush this, but still get the
81/82 bits to guests.
