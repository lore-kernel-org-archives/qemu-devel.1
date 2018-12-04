Received: from eggs.gnu.org ([2001:4830:134:3::10]:57298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUDAc-00014c-U1
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUDAZ-0006h5-FS
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:03:34 -0500
Date: Tue, 4 Dec 2018 17:03:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181204170321.6919aeae.cohuck@redhat.com>
In-Reply-To: <20181204160124.48a32fbe@oc2783563651>
References: <20181204133802.100998-1-borntraeger@de.ibm.com>
	<20181204160124.48a32fbe@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390/MAINTAINERS: Add Halil
 as kvm and machine maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On Tue, 4 Dec 2018 16:01:24 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue,  4 Dec 2018 14:38:02 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > Halil does more work in this area than I do right now. Lets add Halil.
> > 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>  
> 
> Acked-by: Halil Pasic <pasic@linux.ibm.com>

Thanks, applied.

> 
> > ---
> >  MAINTAINERS | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 63effdc473..76fbf1331a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -365,8 +365,9 @@ S: Maintained
> >  F: target/ppc/kvm.c
> >  
> >  S390
> > -M: Christian Borntraeger <borntraeger@de.ibm.com>
> > +M: Halil Pasic <pasic@linux.ibm.com>
> >  M: Cornelia Huck <cohuck@redhat.com>
> > +M: Christian Borntraeger <borntraeger@de.ibm.com>
> >  S: Maintained
> >  F: target/s390x/kvm.c
> >  F: target/s390x/kvm_s390x.h
> > @@ -1057,6 +1058,7 @@ S390 Machines
> >  -------------
> >  S390 Virtio-ccw
> >  M: Cornelia Huck <cohuck@redhat.com>
> > +M: Halil Pasic <pasic@linux.ibm.com>
> >  M: Christian Borntraeger <borntraeger@de.ibm.com>
> >  S: Supported
> >  F: hw/char/sclp*.[hc]  
> 
