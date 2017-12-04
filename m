Received: from eggs.gnu.org ([2001:4830:134:3::10]:37529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eLxUt-0003fh-Hc
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eLxUp-0002Su-Kc
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:37:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eLxUp-0002Sb-Dz
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:37:47 -0500
References: <87bmjeqn1s.fsf@fsf.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <fbff6cd8-e3b8-3baa-b54d-87ce385061d6@redhat.com>
Date: Mon, 4 Dec 2017 21:37:42 +0100
MIME-Version: 1.0
In-Reply-To: <87bmjeqn1s.fsf@fsf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-devel archive search was missing some
 messages but it's fixed now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Kelling <iank@fsf.org>
Cc: qemu-devel@nongnu.org

Hello Ian,

On 12/04/17 21:02, Ian Kelling wrote:

> General thoughts about the archive: I'm looking forward to us upgrading
> to mailman 3 at some point which will bring an improved archive
> interface.

Do you mean HyperKitty?

Will you seek out community feedback on it first?

> Of course, you can always download the archive and search it
> on your local computer.

The one HyperKitty instance that I can readily look at is:

https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/

It only offers the following download options:

- "Past 30 days (mbox)"
- "This month (mbox)"
- "Entire archive (mbox)"

Maybe it's configurable site by site, but I find this lacking compared
to: "download whichever month you want, in isolation", which is offered
by mailman2:

ftp://lists.gnu.org/qemu-devel/

If someone needs it all, the latter remains easy to script with wget,
for example.

(Back to my original point -- judged similarly from the fedora devel
archive, I find HyperKitty hardly usable for normal reading, and I think
it will completely fail for patch series threads and the discussions
under them. HyperKitty is a step towards social media in my opinion, and
as such inappropriate for development lists (again, IMO). I'm happy to
learn otherwise, of course -- are there good counter-examples where
HyperKitty has worked out fine, for archiving email-based patch traffic
and development discussion?)

NB: my opinion on this likely doesn't matter, as I'm not a heavy
qemu-devel contributor.

Thanks
Laszlo
