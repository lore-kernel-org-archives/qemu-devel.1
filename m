Received: from eggs.gnu.org ([2001:4830:134:3::10]:38892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eFefC-0006c8-Nl
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:18:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eFefB-0002jt-RR
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:18:26 -0500
Date: Fri, 17 Nov 2017 12:18:13 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171117111813.acjwkxmfkqm6sz4b@eukaryote>
References: <20171115090947.29883-1-kchamart@redhat.com>
	<0b29e074-6548-d42e-12ab-67419342773e@redhat.com>
	<20171115215433.fpihpl645mlholgo@eukaryote>
	<6ac3e1b3-d3b0-afe4-4d87-e8c421084d7f@redhat.com>
	<20171116091405.pleud7qrqzu5nzhb@eukaryote>
	<20171117104905.GA4795@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117104905.GA4795@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qapi: block-core: Clarify
 events emitted by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

On Fri, Nov 17, 2017 at 11:49:05AM +0100, Kevin Wolf wrote:
> Am 16.11.2017 um 10:14 hat Kashyap Chamarthy geschrieben:
> > On Wed, Nov 15, 2017 at 04:56:13PM -0500, John Snow wrote:

[...]

> > > It's an interesting gotcha that I wasn't really acutely aware of myself,
> > > so having it in the doc format for API programmers who aren't
> > > necessarily digging through our source sounds like a pleasant courtesy.
> > 
> > Indeed, will do.  (Just for my own clarity, did you imply: don't update
> > it in block-core.json?  FWIW, my first instinct is to check the QAPI
> > documentation for such things, that's why I wrote there first :-))
> 
> Will that be a separate patch or do you intend to send a v3?

I can send a separate one if you prefer, but I was intending to send a
v3 with both files fixed as it's just a related trivial change.  Is that
okay?

-- 
/kashyap
