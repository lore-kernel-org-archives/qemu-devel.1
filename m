Received: from eggs.gnu.org ([2001:4830:134:3::10]:48856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duNrG-0006ZB-4x
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duNrF-0000y6-7m
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:06:58 -0400
Date: Tue, 19 Sep 2017 20:06:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170919190634.GK2107@work-vm>
References: <20170710163029.129912-1-vsementsov@virtuozzo.com>
	<20170710163029.129912-4-vsementsov@virtuozzo.com>
	<20170711130650.GD2223@work-vm>
	<2394bb38-de82-8621-eeae-14ffea68869b@virtuozzo.com>
	<b802048c-f5c0-efff-5550-6faed26023cd@redhat.com>
	<1078f013-e554-1d75-d1e8-f24daace5965@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078f013-e554-1d75-d1e8-f24daace5965@virtuozzo.com>
Subject: Re: [Qemu-devel] ping Re: [PATCH v7 03/16] migration: split common
 postcopy out of ram postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: John Snow <jsnow@redhat.com>, kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, mreitz@redhat.com

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> ping for 1-3
> Can we merge them?

I see all of them have R-b's; so lets try and put them in the next
migration merge.

Quintela: Sound good?

Dave

> 22.08.2017 02:34, John Snow wrote:
> > 
> > On 07/11/2017 09:38 AM, Vladimir Sementsov-Ogievskiy wrote:
> > > 11.07.2017 16:06, Dr. David Alan Gilbert wrote:
> > > > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> > > > > Split common postcopy staff from ram postcopy staff.
> > > > > 
> > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > > I'm OK with this; I'm not sure I'd have bothered making the ping's
> > > > dependent on it being RAM.
> > > > 
> > > > (These first few are pretty much a separable series).
> > > It would be grate if you (or Juan?) can take them separately.
> > > 
> > Yes please. I don't think this ever happened, did it? Can we split off
> > 1-3 and re-roll?
> 
> 
> 
> -- 
> Best regards,
> Vladimir
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
