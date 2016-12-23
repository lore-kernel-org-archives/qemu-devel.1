Received: from eggs.gnu.org ([2001:4830:134:3::10]:38134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cKKfn-0007vX-Fw
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 02:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cKKfm-0005Fi-Tz
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 02:53:51 -0500
References: <CAP086mP+iK_CwJ0oq1-gPEDCx88BA9PoncROXsoBYD5xEoGSkA@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <4074823e-d360-517c-c98a-f0402870922a@tuxfamily.org>
Date: Fri, 23 Dec 2016 08:53:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAP086mP+iK_CwJ0oq1-gPEDCx88BA9PoncROXsoBYD5xEoGSkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU for RISC6000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: giancarlo teodori <gteodori@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>

On 22.12.2016 13:01, giancarlo teodori wrote:
> Hi, I'm working to emulate aix SO on RISC6000 environment using qemu
> emulator.
> I tried to import related patch ([RFC,2/6] prep: add IBM RS/6000 7248 (43p)
> machine emulation), but this operation give me an error.
> I'm using a wrong release of qemu code?

Well, if I googled that correctly: The patch is from 2013, so you've
likely got to use a QEMU version from that year if you do not want to
adapt the patch to the latest version manually.

> Do you know a version of qemu already integrated for emulate risc6000?
> Otherwise, at which version of qemu I can apply the patch above?

I've never heard of that patch before ... so I guess it just has been
abandoned?

 Thomas
