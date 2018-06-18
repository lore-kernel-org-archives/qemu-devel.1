Received: from eggs.gnu.org ([2001:4830:134:3::10]:36226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fUujN-000618-K9
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fUujJ-0005Yf-GI
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:02:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1fUujJ-0005Vw-Ay
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:02:01 -0400
Date: Mon, 18 Jun 2018 10:01:53 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180618140153.GB18383@localhost.localdomain>
References: <CAFEAcA_S41uEj=ae1efd042aTJcLUe+LXpD8WUwSkeWLnPCj=w@mail.gmail.com>
	<20180618112622.aqih42lyypqfmmpg@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618112622.aqih42lyypqfmmpg@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] enabling smart-http git protocol on git.qemu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Iliya Dyachenko <gandalfthewhite@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Jun 18, 2018 at 01:26:22PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > >   ScriptAliasMatch "^/git/(.*\.git/(HEAD|info/refs))$" \
> > >     /usr/libexec/git-core/git-http-backend/$1
> > >   ScriptAliasMatch "^/git/(.*\.git/git-(upload|receive)-pack)$" \
> > >     /usr/libexec/git-core/git-http-backend/$1
> > 
> > Sounds like a good idea -- I've cc'd Jeff and Stefan (who
> > are the people who care for our git server)...
> 
> While being at it: seabios git url has changed, can the mirror be
> updated please?  New URL is:
> 
> https://git.seabios.org/seabios.git
> 
> thanks,
>   Gerd
> 

Thanks Gerd.

The seabios upstream url has been updated.  Let me know if there are any
issues.


-Jeff
