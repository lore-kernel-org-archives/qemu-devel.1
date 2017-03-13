Received: from eggs.gnu.org ([2001:4830:134:3::10]:59834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cnTop-00015P-7W
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 13:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cnTok-0001xO-7S
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 13:31:39 -0400
Received: from h2042504.stratoserver.net ([85.214.107.226]:57960)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cnTok-0001vz-1X
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 13:31:34 -0400
References: <20170313165927.19961-1-git@kirschju.re>
	<fe605e60-1a67-bedd-753f-aea0617de778@redhat.com>
From: Julian Kirsch <git@kirschju.re>
Message-ID: <ff145974-0455-4618-b1a5-269e7078995d@kirschju.re>
Date: Mon, 13 Mar 2017 18:31:29 +0100
MIME-Version: 1.0
In-Reply-To: <fe605e60-1a67-bedd-753f-aea0617de778@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] X86/HMP: Expose x86 model specific
 registers via human monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 13.03.2017 18:12, Eric Blake wrote:
> Most HMP commands still use '_'; it is only QMP where we insist on '-'
> in new interfaces.  (And yes, there's not much rhyme or reason to that
> other than backwards consistency.)


Hi Eric,

sorry, I got confused about the "-"/"_" matter by a comment on an earlier
version of the patch set which (as you correctly point out) concerned QMP, not HMP.

Best,
Julian
