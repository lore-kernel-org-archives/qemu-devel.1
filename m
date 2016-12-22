Received: from eggs.gnu.org ([2001:4830:134:3::10]:48622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK1v0-0004Df-Ek
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 06:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK1ux-0007pH-DS
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 06:52:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK1ux-0007p3-7Q
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 06:52:15 -0500
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
	<20161222110616.ocgmojb3vrs46o4c@kamzik.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a1af42f-98c1-ccf3-54c8-417bf4b1d576@redhat.com>
Date: Thu, 22 Dec 2016 12:52:09 +0100
MIME-Version: 1.0
In-Reply-To: <20161222110616.ocgmojb3vrs46o4c@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v8 00/14] VT-d unit test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, rkrcmar@redhat.com, agordeev@redhat.com, jan.kiszka@web.de



On 22/12/2016 12:06, Andrew Jones wrote:
> Alex,
> 
> Are you happy with v8? If so, then, as far as I'm concerned, this
> series is ready. I'd like to try driving the edu device from ARM
> tests too.
> 
> Thanks,
> drew

There are some minor conflicts, but nothing that I cannot fix.  I've
pushed the series.

Paolo
