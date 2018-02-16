Received: from eggs.gnu.org ([2001:4830:134:3::10]:43077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1emdLr-0000ry-GW
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1emdLn-00080P-EL
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:34:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1emdLn-000802-9h
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:34:43 -0500
Date: Fri, 16 Feb 2018 11:34:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180216113424.54e980d0.cohuck@redhat.com>
In-Reply-To: <CAFEAcA_JpeUeWoxyhTzzPAkH-Kc0OwV-r91LP=Mt27z1=icdQA@mail.gmail.com>
References: <20180212124008.8960-1-cohuck@redhat.com>
	<CAFEAcA_JpeUeWoxyhTzzPAkH-Kc0OwV-r91LP=Mt27z1=icdQA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

On Thu, 15 Feb 2018 18:27:29 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 12 February 2018 at 12:40, Cornelia Huck <cohuck@redhat.com> wrote:
> > Some pointers on how to get a patch into stable.
> >
> > [contains some suggestions by mdroth]
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > RFC/D->v2: added mdroth's suggestions
> > ---
> >  docs/stable-process.rst | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 docs/stable-process.rst
> >  
> 
> Drive-by bikeshed comment: should this be in docs/devel ?
> It's aimed at QEMU developers rather than users...

I don't mind moving the shed over to docs/devel/.

OK, I have merged the various comments and pushed the result to

git://github.com/cohuck/qemu stable-doc

Who will merge this? I can send a pull request if needed.
