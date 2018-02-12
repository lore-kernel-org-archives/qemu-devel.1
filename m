Received: from eggs.gnu.org ([2001:4830:134:3::10]:45451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elDLT-0002u9-LV
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elDLR-0008TR-1l
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:36:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1elDLQ-0008SK-UB
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:36:28 -0500
Date: Mon, 12 Feb 2018 13:36:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180212133624.34dd2f49.cohuck@redhat.com>
In-Reply-To: <151840458286.28114.4120688586561065910@sif>
References: <20180209131112.2068-1-cohuck@redhat.com>
	<151840458286.28114.4120688586561065910@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC/D] docs: document our stable process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

On Sun, 11 Feb 2018 21:03:02 -0600
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Cornelia Huck (2018-02-09 07:11:12)
> > Some pointers on how to get a patch into stable.  
> 
> Thanks for putting this together. I made some minor suggestions below
> that might help clarify some points.
> 
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > This probably needs more love, but I'd like to have at least _some_
> > kind of documentation.
> > 
> > Maybe this should also go into the wiki?  
> 
> We can probably add a reference to it in:
> 
>   https://wiki.qemu.org/Contribute/SubmitAPatch

Yes, it makes sense to add a pointer once this is upstream.

> 
> I should probably add a MAINTAINERS entry for stable that references
> it too.

+1

> 
> > 
> > ---
> >  docs/stable-process.rst | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 docs/stable-process.rst

<snip>

I have incorporated your suggestions (sometimes massaged a bit). v2 on
the way.

Thanks for your feedback!
