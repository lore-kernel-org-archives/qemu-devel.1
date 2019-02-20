Received: from eggs.gnu.org ([209.51.188.92]:35795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gwV8o-0002bn-DD
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gwV8m-0003qL-5o
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:54:38 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:39077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gwV8l-0003ob-UU
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:54:36 -0500
Received: from player158.ha.ovh.net (unknown [10.109.159.152])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id CECF011785B
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 17:54:31 +0100 (CET)
Date: Wed, 20 Feb 2019 17:54:25 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190220175425.2eed7b24@bahia.lan>
In-Reply-To: <CAFEAcA9ZTpFCE_KHR=8AT_BJNHLNyLyVmRyjNoJOY4w5Lw2Jyg@mail.gmail.com>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
	<CAFEAcA9ZhMtkh+2CXYjsbYhj69iGgQzBwT2TFOriPgvDbOaPpw@mail.gmail.com>
	<20190220164312.574d48d6@bahia.lan>
	<CAFEAcA9ZTpFCE_KHR=8AT_BJNHLNyLyVmRyjNoJOY4w5Lw2Jyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/43] ppc-for-4.0 queue 20190219
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 20 Feb 2019 15:49:41 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 20 Feb 2019 at 15:43, Greg Kurz <groug@kaod.org> wrote:
> > I have an account. I'll start updating the wiki according to what was
> > actually merged up to this pull request.  
> 
> Thanks. Personally I've found for the arm parts of the changelog
> that it's much easier to update the changelog with every
> pull request, and it's going to result in a more detailed log
> as a result.
> 

Yeah. Cedric and I will take care of that for future pull requests.

Here are the changes I've come up so far:

https://wiki.qemu.org/index.php?title=ChangeLog%2F4.0&diff=8226&oldid=8221

PPC developpers,

Please ping me or Cedric if there are other user-visible changes we
should mention, or even better, update the wiki if you can :)

> -- PMM
> 
