Received: from eggs.gnu.org ([2001:4830:134:3::10]:37703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cIBVB-0003un-Cd
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 04:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cIBV6-0008NT-VV
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 04:42:01 -0500
Received: from mail.avalus.com ([89.16.176.221]:50198)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cIBV6-0008IN-NE
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 04:41:56 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161217083436.paqqlsbkjl66frfr@grep.be>
Date: Sat, 17 Dec 2016 09:41:47 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <E60EEFCC-F2D5-42D6-8408-6C4BF27C8440@alex.org.uk>
References: <D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
	<3D392E31-DDA4-4316-B26D-871E94A83935@alex.org.uk>
	<20161214201858.lblzw2ayddidxfyp@grep.be>
	<58F412AB-8A4C-403F-AEE2-D2FB958D447A@alex.org.uk>
	<20161215150312.dmxrxn7ujzq3apy6@grep.be>
	<78C8A0CB-717D-4925-8AA8-A085DC1F9FB7@alex.org.uk>
	<20161215164917.2zzkdwxarf4pnfle@grep.be>
	<3DDAB833-51BF-4F73-9F08-E50054B01D24@alex.org.uk>
	<20161216155248.2r2yzthuvn76nprq@grep.be>
	<82CDF60E-994F-453F-8B34-181C86001A82@alex.org.uk>
	<20161217083436.paqqlsbkjl66frfr@grep.be>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>


> On 17 Dec 2016, at 08:34, Wouter Verhelst <w@uter.be> wrote:
> 
> I've therefore removed that restriction as well as the "255 bytes max"
> one that you added, since I don't think they make much sense. That
> doesn't mean I can't be convinced otherwise by good arguments, but
> they'd have to be very good ones ;-)

But we were at cross purposes. I was talking about the return from
queries, and you've adjusted namespaces (in toto). I've fixed up
your edit slightly, and brought the return for queries in line
with it. I hope this nit is now dead!

-- 
Alex Bligh
