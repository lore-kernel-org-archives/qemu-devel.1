Received: from eggs.gnu.org ([2001:4830:134:3::10]:59850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTNmr-0006Ex-Ga
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTNmq-0002XI-SN
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:34:49 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149915701334.6295.1724301929524364123.stgit@frigg.lan>
	<149915849243.6295.4484103824675839071.stgit@frigg.lan>
	<d1a9d3b0-96a3-60e0-270b-3e9ef82cafac@redhat.com>
Date: Fri, 07 Jul 2017 09:34:24 +0200
In-Reply-To: <d1a9d3b0-96a3-60e0-270b-3e9ef82cafac@redhat.com> (Eric Blake's
	message of "Wed, 5 Jul 2017 16:14:10 -0500")
Message-ID: <87tw2og0ov.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 6/6] trace: [trivial] Statically enable
 all guest events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, "open list:Trivial patches" <qemu-trivial@nongnu.org>

Eric Blake writes:

> On 07/04/2017 03:54 AM, Llu=C3=ADs Vilanova wrote:
>> The existing optimizations makes it feasible to have them available on a=
ll
>> builds.

> While this change may feel trivial, I think it is a misnomer to include
> "[trivial]" in the subject line, and I also think it should not go in
> through qemu-trivial.  The ideal trivial patch is one that can be
> applied in isolation, but your patch can only be applied as part of a
> series that includes the earlier optimizations that made this one possibl=
e.

Ok. Does this mean I should send a new series without the trivial tag?


Cheers,
  Lluis
