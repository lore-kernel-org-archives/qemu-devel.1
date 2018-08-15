Received: from eggs.gnu.org ([2001:4830:134:3::10]:41441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpjvG-0004ZF-R3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 20:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpjvD-0005ZP-Gs
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 20:44:26 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpjvD-0005ZB-7G
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 20:44:23 -0400
Date: Tue, 14 Aug 2018 20:44:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180815004420.GB17669@flamenco>
References: <20180813171132.21939-1-cota@braap.org>
	<20180813171132.21939-2-cota@braap.org>
	<d9bb9cc8-f9ab-83e9-106e-7f405c6793af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bb9cc8-f9ab-83e9-106e-7f405c6793af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qsp: QEMU's Synchronization Profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>

On Tue, Aug 14, 2018 at 10:13:12 +0200, Paolo Bonzini wrote:
> On 13/08/2018 19:11, Emilio G. Cota wrote:
> > +    struct qsp_report rep;
> 
> Don't like camelcase?  But that's really all that I have to remark on
> this lovely series.

I have a strong aversion to it :-)

But if that's a deal breaker, let me know.

Thanks,

		E.
