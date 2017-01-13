Received: from eggs.gnu.org ([2001:4830:134:3::10]:55657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cRsfu-0007UU-Ea
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cRsfq-0000TG-Ix
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:37:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amit.shah@redhat.com>)
	id 1cRsfq-0000Sz-Cr
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:37:06 -0500
Date: Fri, 13 Jan 2017 09:07:01 +0530
From: Amit Shah <amit.shah@redhat.com>
Message-ID: <20170113033701.GA1955@amit-lp.rh>
References: <1483633930-7103-1-git-send-email-amit.shah@redhat.com>
	<CAFEAcA8nZmDsQvfX+=W3jDJU0rUThsn93fFNYgzxhEyWTx_kHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8nZmDsQvfX+=W3jDJU0rUThsn93fFNYgzxhEyWTx_kHQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/4] migration: QTAILQ migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu list <qemu-devel@nongnu.org>, Jianjun Duan <duanj@linux.vnet.ibm.com>

On (Fri) 06 Jan 2017 [12:10:22], Peter Maydell wrote:
> On 5 January 2017 at 16:32, Amit Shah <amit.shah@redhat.com> wrote:
> > The following changes since commit dbe2b65566e76d3c3a0c3358285c0336ac61e757:
> >
> >   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2016-12-28 17:11:11 +0000)
> >
> > are available in the git repository at:
> >
> >   https://git.kernel.org/pub/scm/virt/qemu/amit/migration.git tags/migration-for-2.9-1
> >
> > for you to fetch changes up to 8d0c57697abcc57166e918064d9a7f6c7316d01b:
> >
> >   migration: add error_report (2017-01-04 19:21:26 +0530)
> >
> > ----------------------------------------------------------------
> > Migration: migrate QTAILQ infrastructure for vmstate
> >
> > ----------------------------------------------------------------
> 
> Hi. I'm afraid this fails 'make check' for ppc64be:

Hi Peter, since this was due to something else, will you try to pull
this in again?  Or should I re-send the series?

Thanks,

		Amit
