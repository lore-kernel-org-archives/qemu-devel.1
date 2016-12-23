Received: from eggs.gnu.org ([2001:4830:134:3::10]:56924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cKGmY-0007Gu-UR
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 22:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cKGmU-0000RC-4S
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 22:44:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cKGmT-0000Qw-Uw
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 22:44:30 -0500
Date: Fri, 23 Dec 2016 11:44:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161223034420.GD26435@pxdev.xzpeter.org>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
	<20161222110616.ocgmojb3vrs46o4c@kamzik.brq.redhat.com>
	<0a1af42f-98c1-ccf3-54c8-417bf4b1d576@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a1af42f-98c1-ccf3-54c8-417bf4b1d576@redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v8 00/14] VT-d unit test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, rkrcmar@redhat.com, agordeev@redhat.com, jan.kiszka@web.de

On Thu, Dec 22, 2016 at 12:52:09PM +0100, Paolo Bonzini wrote:
> 
> 
> On 22/12/2016 12:06, Andrew Jones wrote:
> > Alex,
> > 
> > Are you happy with v8? If so, then, as far as I'm concerned, this
> > series is ready. I'd like to try driving the edu device from ARM
> > tests too.
> > 
> > Thanks,
> > drew
> 
> There are some minor conflicts, but nothing that I cannot fix.  I've
> pushed the series.

Thanks to both!

-- peterx
