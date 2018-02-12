Received: from eggs.gnu.org ([2001:4830:134:3::10]:45454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elINQ-0006vj-J9
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elINN-0005D9-MN
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:58:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1elINN-0005Cn-Gl
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:58:49 -0500
Date: Mon, 12 Feb 2018 18:58:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180212185831.62d1a231.cohuck@redhat.com>
In-Reply-To: <d369e62c-3fe6-060b-9e2a-6ae948d939dd@redhat.com>
References: <20180212124008.8960-1-cohuck@redhat.com>
	<d369e62c-3fe6-060b-9e2a-6ae948d939dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] docs: document our stable process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On Mon, 12 Feb 2018 11:17:38 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/12/2018 06:40 AM, Cornelia Huck wrote:
> > Some pointers on how to get a patch into stable.
> > 
> > [contains some suggestions by mdroth]
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > RFC/D->v2: added mdroth's suggestions
> > ---
> >   docs/stable-process.rst | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 67 insertions(+)
> >   create mode 100644 docs/stable-process.rst
> >   

> What you have is an obvious improvement over the "nothing" that was 
> before, so whether or not you fold in my additional comments, you can add:
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Your comments make sense, so I've folded them in. Thanks!
