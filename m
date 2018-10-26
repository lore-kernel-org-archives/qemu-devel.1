Received: from eggs.gnu.org ([2001:4830:134:3::10]:45841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gG41N-0003kB-Px
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gG41N-0001ek-3e
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:27:33 -0400
Date: Fri, 26 Oct 2018 12:27:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181026152721.GH3902@habkost.net>
References: <20181004161852.11673-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004161852.11673-1-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/10] Trivial fixes and clean ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On Thu, Oct 04, 2018 at 12:18:42PM -0400, Cleber Rosa wrote:
> Just a collection of trivial fixes and clean ups that have been lying
> around here for some time.

I'm queueing patches 07-10 on python-next.  I'm aware that
Laurent already queued some of them (thanks!), but I want to
avoid conflicts in case other patches touching these modules are
queued on python-next.

-- 
Eduardo
