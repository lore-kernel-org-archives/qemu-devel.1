Received: from eggs.gnu.org ([2001:4830:134:3::10]:51096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <revol@free.fr>) id 1cO7oA-0004lc-CO
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 13:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <revol@free.fr>) id 1cO7o5-0001UT-Fq
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 13:58:10 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:42903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <revol@free.fr>) id 1cO7o5-0001SI-8I
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 13:58:05 -0500
References: <20120202110843.18662.48430.malonedeb@wampee.canonical.com>
	<20170101165508.1274.40921.malone@soybean.canonical.com>
From: =?UTF-8?Q?Fran=c3=a7ois_Revol?= <revol@free.fr>
Message-ID: <499be784-ba76-25b9-e2c8-6500812d3e25@free.fr>
Date: Mon, 2 Jan 2017 19:57:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170101165508.1274.40921.malone@soybean.canonical.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 925405] Re: VNC server does not work with Mac
 Screen Sharing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 925405 <925405@bugs.launchpad.net>, qemu-devel@nongnu.org

On 01/01/2017 17:55, Rui Carmo wrote:
> Hey there. Will git tip from September do? At that time I built QEMU on
> Ubuntu 16.04.1, pointed my Mac (10.10) at it again and had the same
> experience (had to use a third-party client)
>
> Considering I opened this four years ago, I'm kind of surprised it's
> still a talking topic. Was kind of expecting more people to report it,
> but then again Launchpad is a bit off the beaten path these days and
> most people just sigh and fetch a third party client.
>
> It's just that it seems like a trivial thing to fix overall, so I
> thought it worthwhile to chime in - Happy New Year!
>


For what it's worth, it's a bug in Apple's client which despite them=20
claiming to "use the industry standard VNC" (whatever that means)=20
clearly violates the VNC specs by replying with a boggus protocol=20
version number.

I told them 5 years ago but it's not like they care about respecting=20
standards...

Fran=E7ois.
