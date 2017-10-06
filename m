Received: from eggs.gnu.org ([2001:4830:134:3::10]:49565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0TK8-0000zj-EN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0TK3-0001HT-Ka
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:09:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0TK3-0001Fz-Dn
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:09:51 -0400
Date: Fri, 6 Oct 2017 16:09:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171006160944.1fd247a3.cohuck@redhat.com>
In-Reply-To: <2e0360e2-6f8d-86e7-9629-bbe1b2568421@linaro.org>
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-18-david@redhat.com>
	<2e0360e2-6f8d-86e7-9629-bbe1b2568421@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/30] MAINTAINERS: use s390 KVM
 maintainers for target/s390x/sigp.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On Fri, 6 Oct 2017 09:40:49 -0400
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 09/28/2017 04:36 PM, David Hildenbrand wrote:
> > All code in target/s390x/sigp.c was factored out from
> > target/s390x/kvm.c, so let's also copy the entry in the MAINTAINERS
> > file.
> > 
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)  
> 
> Probably should squash with previous, but...
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 

Agreed, that makes more sense than keeping it as a standalone patch.
