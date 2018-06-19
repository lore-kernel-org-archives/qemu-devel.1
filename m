Received: from eggs.gnu.org ([2001:4830:134:3::10]:34523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fV9la-0007dW-5k
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fV9lZ-0000ec-71
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:05:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
Date: Tue, 19 Jun 2018 08:05:16 +0200
In-Reply-To: <20180611205203.2624-1-mreitz@redhat.com> (Max Reitz's message of
	"Mon, 11 Jun 2018 22:51:53 +0200")
Message-ID: <87fu1j71lv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/10] block: Try to create well typed
 json:{} filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>

Max Reitz <mreitz@redhat.com> writes:

> See cover letter of v1 here:
> http://lists.nongnu.org/archive/html/qemu-block/2018-05/msg00290.html
>
>
> This series depends on Markus's series "block: Configuration fixes and
> rbd authentication":
>
> Based-on: <20180607062559.16127-1-armbru@redhat.com>

PATCH 06+07 applied to qapi-next as fix of latent bug.  Thanks!
