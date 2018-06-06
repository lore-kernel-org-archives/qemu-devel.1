Received: from eggs.gnu.org ([2001:4830:134:3::10]:60335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQdIx-0006JY-0S
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQdIw-00010D-Bb
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:37:07 -0400
Date: Wed, 6 Jun 2018 15:36:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180606183653.GU7451@localhost.localdomain>
References: <2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606121624.GD2661@work-vm>
	<2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
	<20180606140233.GF2660@work-vm>
	<66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
	<20180606144140.GH2660@work-vm>
	<cea4f615-c768-7a2f-3849-5dd00c37b537@redhat.com>
	<20180606172523.3816a882@kitsune.suse.cz>
	<a1d7851c-e01f-4190-cc8f-af98531e6379@redhat.com>
	<20180606203339.0085207d@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180606203339.0085207d@kitsune.suse.cz>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com

On Wed, Jun 06, 2018 at 08:33:39PM +0200, Michal Such=E1nek wrote:
[...]
> Lastly we are missing a developer of a management layer committed to
> support such appliances.

This is important.  Without developers of management tools
willing to help specify the requirements and implement the
feature, all the work in the lower layers would be useless.

--=20
Eduardo
