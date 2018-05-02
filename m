Received: from eggs.gnu.org ([2001:4830:134:3::10]:50141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fDmR3-0002Id-Hf
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fDmR2-0007xS-Qf
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44776 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fDmR2-0007u2-LV
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:20 -0400
Date: Wed, 2 May 2018 09:44:03 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

  Hi,

> > If we bump the major version each year anyway, why not go the whole way
> > and use 2018.1, 2018.2, ... (or even <year>.<month>)? The nice thing
> > about that is that you can see at a glance when the release took place.
> 
> ... or simply drop the first two digits and call them 18.1, 18.2, ...?

We could also drop the major/minor scheme altogether (as they are
meaningless anyway) and just go for YYMM, i.e. 1808 (for a august
release).

If we go for a time-based numbering scheme:  I'd prefer the year being
part of the version number, for the same reason Thomas mentioned above:
It makes it easy to see when a particular version was released.

cheers,
  Gerd
